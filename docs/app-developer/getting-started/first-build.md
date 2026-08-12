# Basic project example

<!-- markdownlint-disable MD046 -->
<!-- Content tabs (===) indent body text; markdownlint misreports that as indented code blocks. -->

## About this guide

This guide walks through a small Java project to learn how a Maven project is organized and how its `pom.xml` is built up step by step.
It focuses on the [standard directory layout](https://maven.apache.org/guides/introduction/introduction-to-the-standard-directory-layout.html), a minimal `pom.xml`, running a build, declaring dependencies, configuring a plugin, and writing a test.

### Prerequisites

Before starting this tutorial, you should have:

- a basic understanding of what Maven is — see [What is Maven (for)?](../key-concepts/what-maven-is.md)
- Maven installed and available on your `PATH` — see [Installing Apache Maven](../../about/installation.md)

This guide does not assume you read other pages in order.
If you landed here directly, read those two pages first.

The example uses the project folder name `hello-maven` and the Java package `com.example`.
Both names are only examples, choose any project name and package that fit your own work.

## Maven's standard directory layout

Maven expects a predictable folder structure so builds work the same way in every project.
Source code, resources, tests, and the project descriptor each have fixed places under `src/` and the project root.

This is the layout you'll create:

```text
hello-maven/
├── pom.xml
└── src
    ├── main
    │   ├── java
    │   │   └── com
    │   │       └── example
    │   └── resources
    └── test
        ├── java
        │   └── com
        │       └── example
        └── resources
```

- `pom.xml` — project object model: coordinates, dependencies, plugins, and build settings.
- `src/main/java` — production Java sources.
Java maps packages to folders, so package `com.example` lives under `com/example`.
- `src/main/resources` — production non-code files (for example, configuration files on the classpath).
- `src/test/java` — test Java sources, mirroring the main package layout.
- `src/test/resources` — files used only during tests.

## 1. Create the project structure

Run the command for your platform.
It creates every folder above and an empty `pom.xml`.
You'll fill in `pom.xml` in the next step, Java files come later.

=== "macOS / Linux"

    ```sh
    mkdir -p hello-maven/src/{main,test}/{java/com/example,resources} \
      && touch hello-maven/pom.xml
    ```

=== "Windows (PowerShell)"

    ```powershell
    $root = "hello-maven"
    "src/main/java/com/example",
    "src/main/resources",
    "src/test/java/com/example",
    "src/test/resources" |
      ForEach-Object { New-Item -ItemType Directory -Path "$root/$_" -Force | Out-Null }
    New-Item -ItemType File -Path "$root/pom.xml" -Force | Out-Null
    ```

Verify the result with `tree hello-maven` (or `ls -R hello-maven` on macOS/Linux, `dir /s hello-maven` on Windows).
It should match the layout shown above.

## 2. Add project coordinates in `pom.xml`

Create `pom.xml` in the project root with the minimum information Maven needs to identify the project.

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.example</groupId>
  <artifactId>hello-maven</artifactId>
  <version>1.0.0-SNAPSHOT</version>
</project>
```

- `modelVersion` — POM format version, use `4.0.0` for current Maven 3.x and 4.x projects.
- `groupId` — namespace for the project, often a reversed domain (here `com.example`).
- `artifactId` — name of this artifact, usually matches the project folder (`hello-maven`).
- `version` — release version, `SNAPSHOT` marks a development version.

Together, `groupId`, `artifactId`, and `version` are the project **coordinates**.
They uniquely identify the artifact Maven builds.

## 3. Add compiler and encoding properties

Add a `properties` section to control how the compiler and resources behave, without repeating values in every plugin configuration.

```xml
  <properties>
    <maven.compiler.release>17</maven.compiler.release>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>
```

- `maven.compiler.release` — Java language level used when compiling (here Java 17).
The compiler plugin maps this to the `--release` flag so source and bytecode target stay aligned.
- `project.build.sourceEncoding` — character encoding for source and resource files (UTF-8 avoids platform-specific default issues).

## 4. Add application code

For example, create `src/main/java/com/example/App.java` with the following content.

```java
package com.example;

public class App {
    public static String greeting() {
        return "Hello, Maven!";
    }

    public static void main(String[] args) {
        System.out.println(greeting());
    }
}
```

The path under `src/main/java` must match the `package` declaration (`com.example` → `com/example/`).

## 5. Run the first build

From the project root (`hello-maven`), compile and package the project.

```sh
mvn package
```

- `package` — compiles main sources and packages the result into a JAR under `target/`.

Maven creates `target/` automatically.
The JAR name follows the coordinates, for example `target/hello-maven-1.0.0-SNAPSHOT.jar`.

Run the application (adjust the JAR name if your `artifactId` or `version` differ):

```sh
java -cp target/hello-maven-1.0.0-SNAPSHOT.jar com.example.App
```

After the build finishes, compiled classes, the packaged JAR, and other build output live in the `target/` directory at the project root.
To remove that output (for example before sharing the project folder or to force a full rebuild), run:

```sh
mvn clean
```

## 6. Add a compile-scoped dependency

Dependencies declare libraries Maven downloads and places on the classpath.
**Compile** scope (the default when `scope` is omitted) applies to production code: the library is available when compiling and running the main application.

Add a `dependencies` section to `pom.xml`.
The example below uses Apache Commons Lang, it is not used in `App.java` here, but it shows how a typical compile dependency is declared.

```xml
  <dependencies>
    <dependency>
      <groupId>org.apache.commons</groupId>
      <artifactId>commons-lang3</artifactId>
      <version>3.17.0</version>
    </dependency>
  </dependencies>
```

When Maven runs goals such as `compile` or `package`, it resolves declared dependencies from configured repositories (by default [Maven Central](https://search.maven.org/)) and caches them locally.

## 7. Add a test-scoped dependency

Tests often use a separate library that must not ship with the application.
**Test** scope limits a dependency to compiling and running tests.

Add JUnit Jupiter inside the same `dependencies` block (alongside the compile dependency from the previous step).

```xml
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter</artifactId>
      <version>6.1.0</version>
      <scope>test</scope>
    </dependency>
```

A dependency with `test` scope is not on the classpath when packaging the main JAR for production use.

## 8. Add a plugin for running tests

Plugins attach behavior to Maven's [build lifecycle](https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html).
The Surefire plugin runs unit tests during the `test` phase.

Add a `build` section to `pom.xml`:

```xml
  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-surefire-plugin</artifactId>
        <version>3.5.3</version>
      </plugin>
    </plugins>
  </build>
```

Without a compatible Surefire version, JUnit 6 tests may not be discovered or executed.

## 9. Add a test class

Steps 7 and 8 added JUnit and the Surefire plugin so Maven can compile and run tests.
This step adds a small unit test that checks `App.greeting()` returns the expected text.

Automated tests catch regressions when code changes and document expected behavior for other developers.
In the next step, `mvn test` runs this class through Surefire as part of the build.

For example, create `src/test/java/com/example/AppTest.java`:

```java
package com.example;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class AppTest {
    @Test
    void greeting_returnsExpectedText() {
        assertEquals("Hello, Maven!", App.greeting());
    }
}
```

Test classes live under `src/test/java` with the same package layout as the code they verify.

## 10. Run the tests

From the project root:

```sh
mvn test
```

Maven compiles main and test sources, then Surefire runs the tests in `AppTest`.
The `test` phase also runs earlier [lifecycle](https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html) phases (including `compile`), which is why invoking `mvn test` compiles sources even though you did not call `mvn compile` explicitly.
If the build finishes with `BUILD SUCCESS`, the project layout, `pom.xml`, dependency scopes, and plugin configuration are working together.

If the build fails instead, check the following before re-running:

- **BUILD FAILURE with a compilation error** — usually a typo in `App.java` or `AppTest.java`, or a package/folder mismatch (see [step 4](#4-add-application-code)).
- **No tests found / tests not discovered** — confirm the Surefire plugin from [step 8](#8-add-a-plugin-for-running-tests) is present in `pom.xml`; JUnit 6 tests are not discovered without it.
- **Dependency resolution errors** — check your network connection and that the `groupId`, `artifactId`, and version in [step 6](#6-add-a-compile-scoped-dependency) and [step 7](#7-add-a-test-scoped-dependency) are typed correctly.

Compare your `pom.xml` against the complete file below to spot differences.

### ✅ Verify your `pom.xml` file

After all steps, `pom.xml` should look like this (use it to verify your file).

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.example</groupId>
  <artifactId>hello-maven</artifactId>
  <version>1.0.0-SNAPSHOT</version>

  <properties>
    <maven.compiler.release>17</maven.compiler.release>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>

  <dependencies>
    <dependency>
      <groupId>org.apache.commons</groupId>
      <artifactId>commons-lang3</artifactId>
      <version>3.20.0</version>
    </dependency>
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter</artifactId>
      <version>6.1.0</version>
      <scope>test</scope>
    </dependency>
  </dependencies>

  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-surefire-plugin</artifactId>
        <version>3.5.3</version>
      </plugin>
    </plugins>
  </build>
</project>
```
