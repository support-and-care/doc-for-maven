# The dependency mechanism

Maven's *dependency mechanism* is how a project declares the libraries it needs, how Maven resolves the libraries those libraries depend on, and how it chooses a single version when the same library is resolved in more than one version.

Understanding the dependency mechanism helps you read a `pom.xml`, see how Maven builds a reproducible classpath, and explain why a particular JAR was chosen.

## Why Maven manages dependencies

Almost every Java project uses third-party libraries.
Without a build tool, developers download JAR files by hand, copy them into the project, and hope that every machine was set up the same way, with the same versions.
It is also hard to see later which libraries the project actually needs, because that information lives in a `lib/` folder instead of in one clear list.

Maven replaces these error-prone manual steps with a declaration.
You list each direct dependency once in `pom.xml`.
Maven downloads it from a repository, stores it in the local repository, and puts it on the correct classpath for compilation, testing, or runtime.

The dependency list is also documentation.
Anyone can open the POM and see which libraries the project depends on, instead of reconstructing that from a `lib/` directory.

## Artifact coordinates

In Maven, a reusable build output such as a JAR is called an *artifact*.
With Maven you do not declare a dependency by its download URL.
You declare it by its *coordinates*, and Maven resolves that artifact through the configured artifact repositories.

Coordinates are often abbreviated as *GAV* (`groupId`, `artifactId`, and `version`):

- `groupId` is the organization or project, for example `org.junit.jupiter`.
- `artifactId` is the specific module, for example `junit-jupiter`.
- `version` is the release to use.

Together these values uniquely identify an artifact in a repository such as [Maven Central](https://search.maven.org/).

Optional fields such as `type` (default `jar`) and `classifier` matter when the same module publishes more than one artifact.

## Transitive dependencies

Libraries that your project needs only because another library needs them are called *transitive dependencies*.

When project P depends on library A, and A depends on library B, Maven adds B to project P automatically.

Maven finds them by reading each dependency's POM from the repository.
There is no fixed depth limit.
A can depend on B, B on C, C on D, and so on until the dependency tree is complete or a cycle is detected.

In this example, project P declares A and E.
A pulls in B, and B pulls in C:

``` mermaid
graph TD
  P["Project P"] --> A["Library A<br/>(declared)"]
  A --> B["Library B<br/>(transitive)"]
  B --> C["Library C<br/>(transitive)"]
  P --> E["Library E<br/>(declared)"]
```

That is why a short `<dependencies>` list is enough for a real application, and why the resolved classpath is usually much larger than what you wrote in the POM.

## Dependency mediation

The set of direct and transitive dependencies forms a *dependency tree* (sometimes called a dependency graph).
Different parts of that tree may ask for different versions of the same library.
Only one version can sit on the classpath, so Maven must choose.
That choice is *dependency mediation*.

Maven uses the *nearest definition*.
The version with the shortest path to your project wins.
If two competing paths sit at the same depth, Maven picks the version reached through the dependency that appears first in the POM.

Here is an example.
Project P depends on A and E.
A depends on B, and B depends on D 2.0.
E depends directly on D 1.0.
Maven selects D 1.0 because the path `P → E → D` is shorter than `P → A → B → D`:

``` mermaid
graph TD
  P["Project P"] --> A["A"]
  P --> E["E"]
  A --> B["B"]
  B --> D2["D 2.0<br/>(depth 3)"]
  E --> D1["D 1.0<br/>(depth 2) — selected"]
```

You can override the choice by declaring the dependency directly in your project.
A direct dependency is always closer than a transitive one.

You can also pin versions of *transitive* dependencies with [`dependencyManagement`](#dependency-management).
Managed versions override mediation for those transitive dependencies.
A version you set on a direct dependency in `<dependencies>` still wins for that direct dependency.

## Dependency scope

*Scope* controls two things: when the dependency is on the classpath, and whether it propagates to projects that depend on yours.

Each scope plays a different role in the build.
The table below summarizes those roles.
For background on what a classpath is in Java, see the [Java documentation on the classpath](https://docs.oracle.com/javase/8/docs/technotes/tools/findingclasses.html).

| Scope | Description | On compile classpath | On runtime classpath | On test classpath | Transitive to dependents |
| --- | --- | --- | --- | --- | --- |
| `compile` (default) | Needed to compile and run the application | yes | yes | yes | yes |
| `provided` | Needed at compile time, supplied at runtime by the JDK or a container (for example the Servlet API) | yes | no | yes | no |
| `runtime` | Needed to run the application, but not to compile it (for example a JDBC driver) | no | yes | yes | yes |
| `test` | Only for compiling and running tests (for example JUnit or Mockito) | no | no | yes | no |
| `system` | Like `provided`, but loaded from a local file path (avoid when possible) | yes | yes | yes | no |
| `import` | Imports another POM's managed dependencies inside `dependencyManagement`, such as a [BOM](#bills-of-materials-and-imports) | | | | replaced by managed dependencies |

Scopes also shape what travels through the tree.
A `test` dependency does not add its own dependencies to your main compile classpath.
A `provided` dependency is not passed on as a compile dependency to downstream projects.

## Dependency management

The `<dependencies>` section usually does three jobs at once.
It adds a dependency to the project and sets its version and scope.

`<dependencyManagement>` splits version and shared configuration apart from adding the dependency to the classpath.

!!! note "`dependencyManagement` is not a dependency"
    Entries under `dependencyManagement` do not put anything on the classpath by themselves.
    Listing a library only there does not make it available to compile or run your code.
    You still declare the dependency under `<dependencies>` when your project needs it on the classpath.

Managed entries hold shared details such as version, scope, exclusions, and type.

Child modules can then declare the same dependency without repeating the version.
Transitive dependencies can also be pinned to a chosen version instead of leaving the result to mediation alone.

That is why multi-module projects often keep shared versions in a parent POM.
Child modules stay shorter, and every module uses the same lineup.

Managed versions override dependency mediation for transitive dependencies.
If you set a version directly on a dependency in the current POM's `<dependencies>` block, that version still wins for that direct dependency.

!!! tip "Declare what your code imports"
    If your source code imports classes from library B, declare B as a direct dependency even when it already arrives through library A.
    The build stays more stable if A later removes or replaces B, and the POM documents what your project actually uses.
    You can also pin shared versions with `dependencyManagement` when several modules need the same lineup.

## Bills of materials and imports

Think of a manufacturing *bill of materials*: a parts list that says which components, in which versions, belong together to build a product.
A Maven *bill of materials* (BOM) plays the same role for libraries.
It is a special POM that publishes a compatible set of versions for a family of artifacts, so related libraries stay aligned and you do not repeat versions in every project.

Projects pull that list in with an `import` scoped dependency inside `dependencyManagement`.
Common examples include the JUnit BOM, Spring Boot, Jackson, and Jakarta EE stacks.

Import the BOM like this.
Maven replaces the import with the managed dependencies from that POM.

After you import the BOM, you can declare its managed dependencies without writing versions again:

```xml
<dependencyManagement>
  <dependencies>
    <dependency>
      <groupId>org.junit</groupId>
      <artifactId>junit-bom</artifactId>
      <version>5.10.2</version>
      <type>pom</type>
      <scope>import</scope>
    </dependency>
  </dependencies>
</dependencyManagement>

<dependencies>
  <dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter</artifactId>
    <scope>test</scope>
    <!-- version comes from the BOM -->
  </dependency>
</dependencies>
```

If two imported BOMs manage the same dependency, Maven uses the version from the BOM imported first, unless your own `dependencyManagement` overrides it.

## Optional dependencies and exclusions

Two more features reshape the dependency tree without changing coordinates.

**Optional dependencies** let a library author mark a dependency with `<optional>true</optional>`.
Downstream projects do not get that dependency unless they declare it themselves.

**Exclusions** let a project drop a transitive dependency from one dependency's subtree with an `<exclusions>` block.
The exclusion applies only to that dependency.
Another dependency can still bring the same library in.

Use exclusions when you mean to replace or remove something the upstream tree would otherwise include, such as a logging implementation.
If your own code uses a library directly, declare it as a direct dependency instead of relying on it arriving transitively.

## Putting the pieces together

When Maven builds a project, it roughly does the following (this is a mental model, not a strict description of every internal step):

1. Collect direct dependencies from the effective POM.
2. Resolve transitive dependencies by reading upstream POMs.
3. While building the tree, apply scopes, optional dependencies, exclusions, and `dependencyManagement`.
4. Resolve remaining version conflicts with dependency mediation.
5. Build the compile, test, and runtime classpaths.

The easiest way to inspect the result is using the `tree` goal of the `maven-dependency-plugin`:

```bash
mvn dependency:tree
```

Each line shows a resolved dependency and its scope.
Indentation shows which dependency brought it in.

If the tree is not what you expected, check whether the dependency was declared directly or arrived transitively, which scope it uses, whether mediation or `dependencyManagement` picked the version, and whether it was optional or excluded.

## Next steps

- [Basic project sample](../get-started/basic-project-sample.md).
  Add compile- and test-scoped dependencies in a small project from scratch.
- [Optional Dependencies and Dependency Exclusions](https://maven.apache.org/guides/introduction/introduction-to-optional-and-excludes-dependencies.html).
  When to mark dependencies optional, and how exclusions reshape the graph.
- [POM Reference — Dependencies](https://maven.apache.org/pom.html#Dependencies).
  Every dependency element and attribute.
- [Apache Maven Dependency Plugin](https://maven.apache.org/plugins/maven-dependency-plugin/).
  Goals such as `dependency:tree` and `dependency:analyze`.
- [Introduction to the Dependency Mechanism](https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html).
  The classic Maven write-up, including fuller BOM examples.
