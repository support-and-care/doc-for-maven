# How to add and exclude dependencies

This guide shows how to declare a library in your `pom.xml`, remove an unwanted *transitive* dependency it brings in, and put a compatible replacement on the classpath when needed.

## Prerequisites

Before starting this guide, you should have:

- Maven installed and available on your `PATH`.
See [Installing Apache Maven](../get-started/install-maven.md).
- A Maven project with a working `pom.xml` that builds successfully (`mvn package`).
- Completed the [Basic project sample](../get-started/basic-project-sample.md), or equivalent familiarity with project coordinates and the `<dependencies>` section.

## Step 1: Add a dependency

Declare the library under `<dependencies>` in `pom.xml`.
Maven identifies each artifact by its *coordinates* (`groupId`, `artifactId`, and `version`).

```xml
<dependencies>
  <dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-dbcp2</artifactId>
    <version>2.13.0</version>
  </dependency>
</dependencies>
```

Omit `<scope>` to use the default `compile` scope.
That puts the library on the classpath for compiling, testing, and running the main application.
Use `<scope>test</scope>` for libraries needed only when compiling and running tests, such as JUnit.

!!! tip "Maven dependency scopes"
    Maven supports several scopes that control when a dependency is on the classpath, including `compile`, `provided`, `runtime`, and `test`.
    See [Dependency Scope](https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html#Dependency_Scope) for the full list and how each scope affects transitive dependencies.

Look up coordinates for public libraries on [Maven Central Search](https://search.maven.org/).

!!! tip "Prefer explicit direct dependencies"
    If your source code imports types from a library, declare that library in your POM even when another dependency already pulls it in transitively.
    That keeps the build stable when upstream dependency graphs change.

## Step 2: Inspect what the dependency brought with it

One declared dependency usually resolves to more than one JAR.
Maven also resolves the dependencies of your dependencies (*transitive* dependencies) and puts them on the classpath without naming them in your POM.

Print the dependency tree with the command below so you can inspect all transitive dependencies.

```sh
mvn dependency:tree
```

You should see similar command output:

```text
[INFO] --- dependency:3.7.0:tree (default-cli) @ your-artifact ---
[INFO] com.example:your-artifact:jar:1.0.0-SNAPSHOT
[INFO] \- org.apache.commons:commons-dbcp2:jar:2.13.0:compile
[INFO]    +- org.apache.commons:commons-pool2:jar:2.12.0:compile
[INFO]    +- commons-logging:commons-logging:jar:1.3.4:compile
[INFO]    \- jakarta.transaction:jakarta.transaction-api:jar:1.3.3:compile
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
```

Read each line as `groupId:artifactId:type:version:scope`.
Indentation shows who pulled in what.
`commons-dbcp2` is what you declared.
The three artifacts under it arrived with it.
The exact output may differ depending on the dependency version.

Run `mvn dependency:tree` again after every change in this guide.
It shows the dependency graph Maven resolved for the project.

If you see `Could not find artifact`, check that `groupId`, `artifactId`, and `version` match [Maven Central](https://search.maven.org/), and that your machine can reach the configured repositories.

If the dependency is missing from the tree, confirm you added it inside `<dependencies>`, not only inside `<dependencyManagement>`.
`<dependencyManagement>` pins versions and other details for reuse.
It does not add the library to the classpath by itself.
A dependency must still be declared under `<dependencies>` for it to participate in dependency resolution.
For more on `<dependencies>` versus `<dependencyManagement>`, see [Dependency Management](https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html#Dependency_Management).

## Step 3: Exclude an unwanted transitive dependency

Suppose you do not want `commons-logging` on the classpath because the project routes logging through SLF4J instead.
Add an `<exclusions>` block on the **direct dependency** that pulls it in.

```xml
<dependency>
  <groupId>org.apache.commons</groupId>
  <artifactId>commons-dbcp2</artifactId>
  <version>2.13.0</version>
  <exclusions>
    <exclusion>
      <groupId>commons-logging</groupId>
      <artifactId>commons-logging</artifactId>
    </exclusion>
  </exclusions>
</dependency>
```

An exclusion only accepts `groupId` and `artifactId`.
You cannot and do not need to specify a version.
It removes that artifact from this branch of the tree, whatever version would have been chosen.

Exclusions are per dependency.
If a second dependency also pulls in `commons-logging`, it needs its own `<exclusions>` block.

!!! warning "Use exclusions intentionally"
    Prefer upgrading the upstream dependency, or declaring a direct dependency when your own code imports that library.
    Exclusions are appropriate when you need to control the dependency graph, for example to replace a logging implementation or drop a transitive artifact you cannot accept.

## Step 4: Replace what you removed when the library still needs it

Removing a library that your dependency calls at runtime can cause failures unless something compatible takes its place.
`jcl-over-slf4j` is a logging bridge.
It provides an implementation of the Commons Logging API and redirects calls made through that API to SLF4J, so `commons-dbcp2` keeps working.
Declare it with `runtime` scope because your code does not compile against it.
It is only needed when libraries call Commons Logging at runtime.

```xml
<dependency>
  <groupId>org.slf4j</groupId>
  <artifactId>jcl-over-slf4j</artifactId>
  <version>2.0.17</version>
  <scope>runtime</scope>
</dependency>
```

Print the dependency tree again with the command below so you can compare it with the earlier output that still contained the transitive dependency `commons-logging`.

```sh
mvn dependency:tree
```

You should see similar command output.
`commons-logging` is gone, and the replacement sits at the top level.

```text
[INFO] --- dependency:3.7.0:tree (default-cli) @ your-artifact ---
[INFO] com.example:your-artifact:jar:1.0.0-SNAPSHOT
[INFO] +- org.apache.commons:commons-dbcp2:jar:2.13.0:compile
[INFO] |  +- org.apache.commons:commons-pool2:jar:2.12.0:compile
[INFO] |  \- jakarta.transaction:jakarta.transaction-api:jar:1.3.3:compile
[INFO] \- org.slf4j:jcl-over-slf4j:jar:2.0.17:runtime
[INFO]    \- org.slf4j:slf4j-api:jar:2.0.17:runtime
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
```

If you see `package ... does not exist` after an exclusion, your own code was importing classes from the excluded artifact and relying on it arriving transitively.
Declare that artifact directly in `<dependencies>`, or provide a compatible replacement.
Code you import from is a dependency of your project.

If you see `NoClassDefFoundError` at runtime, a library you use still needs the excluded classes, even though your own source never imported them.
Compilation can succeed because you did not reference those types.
The JVM fails later when the library loads them.
Put a compatible replacement on the classpath (as with `jcl-over-slf4j` above), or do not exclude that artifact.

If the excluded artifact is still listed, the `<groupId>` or `<artifactId>` in `<exclusion>` does not match the tree.
Copy both values exactly from the `dependency:tree` output.
For this example, the coordinates are `commons-logging:commons-logging`, not `org.apache.commons:commons-logging`.

If the artifact disappears from one path but reappears under another dependency, run `mvn dependency:tree -Dverbose -Dincludes=commons-logging:commons-logging` to see every path.
Then add an `<exclusions>` block on each direct dependency at the head of those paths.

## Step 5: Exclude every transitive dependency (optional)

This step is a variant, not part of the running example.
Skip it if you want to keep following the single exclusion and replacement from steps 3 and 4.
To prevent all transitive dependencies of a dependency from being included through that declaration, use `*` for both coordinates.

```xml
<dependency>
  <groupId>org.apache.commons</groupId>
  <artifactId>commons-dbcp2</artifactId>
  <version>2.13.0</version>
  <exclusions>
    <exclusion>
      <groupId>*</groupId>
      <artifactId>*</artifactId>
    </exclusion>
  </exclusions>
</dependency>
```

The tree collapses to the declared artifact alone.

```text
[INFO] com.example:your-artifact:jar:1.0.0-SNAPSHOT
[INFO] \- org.apache.commons:commons-dbcp2:jar:2.13.0:compile
```

!!! warning "A wildcard exclusion hides future breakage"
    Every artifact the library needs is now your responsibility, including ones added in later versions.
    Nothing warns you when an upgrade introduces a new required dependency.
    The build can succeed and fail at runtime.
    Use this only when you intend to supply the full set yourself, for example when a platform BOM already manages those artifacts.
    For anything else, name the artifacts you want gone.

### Verify

Run a full build so compile and test classpaths still work.

```sh
mvn package
```

Then confirm the excluded artifact is gone by filtering the tree.
The `-Dincludes` option uses the [dependency tree filter pattern syntax](https://maven.apache.org/plugins/maven-dependency-plugin/examples/filtering-the-dependency-tree.html).

```sh
mvn dependency:tree -Dincludes=commons-logging:commons-logging
```

You should see similar command output.
Empty output between the goal banner and the separator means nothing on the classpath brings it in.

```text
[INFO] --- dependency:3.7.0:tree (default-cli) @ your-artifact ---
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
```

## The complete `pom.xml` fragment

After steps 1 to 4, the dependency section looks like this.
The wildcard exclusion from step 5 is deliberately left out.

```xml
<dependencies>
  <dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-dbcp2</artifactId>
    <version>2.13.0</version>
    <exclusions>
      <exclusion>
        <groupId>commons-logging</groupId>
        <artifactId>commons-logging</artifactId>
      </exclusion>
    </exclusions>
  </dependency>

  <dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>jcl-over-slf4j</artifactId>
    <version>2.0.17</version>
    <scope>runtime</scope>
  </dependency>
</dependencies>
```

## Further reading

- [Introduction to the Dependency Mechanism](https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html).
Covers scopes, mediation, and `dependencyManagement` when a resolved version surprises you and the tree alone does not explain it.
- [Optional Dependencies and Dependency Exclusions](https://maven.apache.org/guides/introduction/introduction-to-optional-and-excludes-dependencies.html).
When library authors should mark dependencies optional instead of forcing consumers to exclude them.
- [POM Reference (Dependencies)](https://maven.apache.org/pom.html#Dependencies).
Full element reference for `<dependency>`, including type, classifier, and optional.
- [Apache Maven Dependency Plugin](https://maven.apache.org/plugins/maven-dependency-plugin/).
Other goals such as `dependency:analyze`, which reports dependencies you use without declaring and dependencies you declare without using.
- [Basic project sample](../get-started/basic-project-sample.md).
A from-scratch walkthrough that adds compile- and test-scoped dependencies in a small project.
