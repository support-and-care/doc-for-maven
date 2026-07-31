# The dependency mechanism

Maven's dependency mechanism is how a project declares the libraries it needs, how Maven resolves the libraries those libraries depend on, and how it chooses a single version when several versions of the same library appear in the graph.

Understanding it helps you read a `pom.xml`, see how Maven builds a reproducible classpath, and explain why a particular JAR shows up in `mvn dependency:tree`.

## Why Maven manages dependencies

Almost every Java project uses third-party libraries.
Without a build tool, developers download JAR files by hand, copy them into the project, and hope every machine uses the same versions.

Maven replaces that with a declaration.
You list each dependency once in `pom.xml`.
Maven downloads it from a repository, stores it in the local repository, and puts it on the correct classpath for compilation, testing, or runtime.

The dependency list is also documentation.
Anyone can open the POM and see which libraries the project depends on, instead of reconstructing that from a `lib/` directory.

## Artifact coordinates

Maven identifies every artifact by its *coordinates*.

- `groupId` is the organization or project, for example `org.junit.jupiter`.
- `artifactId` is the specific module, for example `junit-jupiter`.
- `version` is the release to use.

Together these values uniquely identify an artifact in a repository such as [Maven Central](https://search.maven.org/).

Optional fields such as `type` (default `jar`) and `classifier` matter when the same module publishes more than one artifact.

A dependency declaration is not "download this file from this URL."
It tells Maven to resolve those coordinates through the configured repositories.

## Transitive dependencies

When your project depends on library B, and B depends on library C, Maven adds C to your project automatically.
Those indirectly included libraries are *transitive dependencies*.

Maven finds them by reading each dependency's POM from the repository.
There is no fixed depth limit.
B can depend on C, C on D, D on E, and so on until the graph is complete or a cycle is detected.

``` mermaid
graph TD
  A["Your project"] --> B["Library B<br/>(declared)"]
  B --> C["Library C<br/>(transitive)"]
  C --> D["Library D<br/>(transitive)"]
  A --> E["Library E<br/>(declared)"]
```

That is why a short `<dependencies>` list is enough for a real application, and why the resolved classpath is usually much larger than what you wrote in the POM.

!!! tip "Declare what your code imports"
    If your source code imports classes from library C, declare C as a direct dependency even when it already arrives through B.
    The build stays more stable if B later removes or replaces C, and the POM documents what your project actually uses.

## Dependency mediation

Different parts of the graph may ask for different versions of the same library.
Only one version can sit on the classpath, so Maven must choose.
That choice is *dependency mediation*.

Maven uses the *nearest definition*.
The version with the shortest path to your project wins.
If two versions sit at the same depth, Maven picks the one whose dependency appears first in the POM.

``` mermaid
graph TD
  A["Project A"] --> B["B"]
  A --> E["E"]
  B --> C["C"]
  C --> D2["D 2.0<br/>(depth 3)"]
  E --> D1["D 1.0<br/>(depth 2) — selected"]
```

In this example, project A depends on B and E.
B depends on C, and C depends on D 2.0.
E depends directly on D 1.0.
Maven selects D 1.0 because the path `A → E → D` is shorter than `A → B → C → D`.

You can override the choice by declaring the dependency directly in your project.
A direct dependency is always closer than a transitive one.

You can also pin versions with [`dependencyManagement`](#dependency-management), which overrides mediation for transitive dependencies.

## Dependency scope

*Scope* controls two things.
When is the dependency on the classpath, and does it propagate to projects that depend on yours?

| Scope | On compile classpath | On runtime classpath | On test classpath | Transitive to dependents |
| --- | --- | --- | --- | --- |
| `compile` (default) | yes | yes | yes | yes |
| `provided` | yes | no | yes | no |
| `runtime` | no | yes | yes | yes |
| `test` | no | no | yes | no |
| `system` | yes | yes | yes | no |
| `import` | | | | replaced by managed dependencies |

Each scope plays a different role in the build.

`compile` is the default.
The dependency is needed to compile and run the application.

`provided` is needed during compilation, but the JDK or a container supplies it at runtime.
The Servlet API is a typical example.

`runtime` is not required for compilation, but it is needed when the application runs.
JDBC drivers often use this scope.

`test` is only for compiling and running tests, for example JUnit or Mockito.

`system` is similar to `provided`, except the dependency comes from a local file instead of a repository.
Avoid it when you can.
It ties the build to one machine.

`import` is only valid inside `dependencyManagement` on a POM dependency.
It pulls in another POM's managed dependencies, such as a [BOM](#bills-of-materials-and-imports).

Scopes also shape what travels through the tree.
A `test` dependency does not add its own dependencies to your main compile classpath.
A `provided` dependency is not passed on as a compile dependency to downstream projects.

## Dependency management

The `<dependencies>` section usually does two jobs at once.
It adds a dependency to the project and sets its version.

`<dependencyManagement>` splits those jobs apart.

Entries under `dependencyManagement` do not put anything on the classpath by themselves.
They hold shared details such as version, scope, exclusions, and type.

Child modules can then declare the same dependency without repeating the version.
Transitive dependencies can also be pinned to a chosen version instead of leaving the result to mediation alone.

That is why multi-module projects often keep shared versions in a parent POM.
Child modules stay shorter, and every module uses the same lineup.

!!! note "`dependencyManagement` is not a dependency"
    A library listed only under `dependencyManagement` does not appear in `mvn dependency:tree` until something under `<dependencies>`, or a transitive dependency, actually requests it.

Managed versions override dependency mediation for transitive dependencies.
If you set a version directly on a dependency in the current POM, that version still wins for that direct dependency.

## Bills of materials and imports

A project can inherit only one parent POM, but it can import several dependency management lists.

Declare another POM inside `dependencyManagement` with `<type>pom</type>` and `<scope>import</scope>`.
Maven replaces the import with the managed dependencies from that POM.

Those POMs are often called a *bill of materials* (BOM).
A BOM publishes compatible versions for a family of libraries, such as Spring Boot, Jackson, or Jakarta EE.

After you import the BOM, you can declare its managed dependencies without writing versions again.

```xml
<dependencyManagement>
  <dependencies>
    <dependency>
      <groupId>org.example</groupId>
      <artifactId>example-bom</artifactId>
      <version>1.0.0</version>
      <type>pom</type>
      <scope>import</scope>
    </dependency>
  </dependencies>
</dependencyManagement>

<dependencies>
  <dependency>
    <groupId>org.example</groupId>
    <artifactId>example-core</artifactId>
    <!-- version comes from the BOM -->
  </dependency>
</dependencies>
```

If two imported BOMs manage the same dependency, Maven uses the version from the BOM imported first, unless your own `dependencyManagement` overrides it.

## Optional dependencies and exclusions

Two more features reshape the graph without changing coordinates.

*Optional dependencies* let a library author mark a dependency with `<optional>true</optional>`.
Downstream projects do not get that dependency unless they declare it themselves.

*Exclusions* let a project drop a transitive dependency from one dependency's subtree with an `<exclusions>` block.
The exclusion applies only to that dependency.
Another dependency can still bring the same library in.

Use exclusions when you mean to replace or remove something the upstream graph would otherwise include, such as a logging implementation.
If your own code uses a library directly, declare it as a direct dependency instead of relying on it arriving transitively.

## Putting the pieces together

When Maven builds a project, it roughly does the following.

1. Collect direct dependencies from the effective POM.
2. Resolve transitive dependencies by reading upstream POMs.
3. Apply scopes, optional dependencies, and exclusions while walking the graph.
4. Resolve version conflicts with `dependencyManagement` and dependency mediation.
5. Build the compile, test, and runtime classpaths.

The easiest way to inspect the result is:

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
