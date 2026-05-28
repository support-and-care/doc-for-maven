# Basic project example

This guide provides a small step-by-step example project that covers the basics of Maven.
It includes the structure of a Maven project, build execution, dependencies, plugins, and tests.

## 1. Create a minimal project

Create a folder named `hello-maven` with the following structure.

```text
hello-maven/
├── pom.xml
└── src
    ├── main
    │   └── java
    │       └── com
    │           └── example
    │               └── App.java
    └── test
        └── java
            └── com
                └── example
                    └── AppTest.java
```

This is Maven's standard directory layout.
Production code is stored in `src/main/java`.
Test code is stored in `src/test/java`.

## 2. Add `pom.xml`

Create a `pom.xml` file in the project root.

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.example</groupId>
  <artifactId>hello-maven</artifactId>
  <version>1.0.0-SNAPSHOT</version>

  <properties>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>
</project>
```

The coordinates `groupId`, `artifactId`, and `version` uniquely identify the artifact.

## 3. Add application code

Create `src/main/java/com/example/App.java`.

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

## 4. Execute the Maven build

Run the build from the project root.

```sh
mvn clean package
```

`clean` removes old build output.
`package` compiles and packages the project into a JAR.
Maven creates the `target/` directory automatically during the build.
The JAR is created in `target/`, for example `target/hello-maven-1.0.0-SNAPSHOT.jar`.

Run the compiled application with the following command.

```sh
java -cp target/hello-maven-1.0.0-SNAPSHOT.jar com.example.App
```

## 5. Add a dependency

Add JUnit to `pom.xml` to support test execution.

```xml
<dependencies>
  <dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter</artifactId>
    <version>5.13.1</version>
    <scope>test</scope>
  </dependency>
</dependencies>
```

A dependency with `test` scope is available only when compiling and running tests.
When Maven goals are executed, declared dependencies are downloaded automatically from configured repositories.
The default repository is Maven Central.

## 6. Add a plugin

Plugins are reusable build components that add behavior to the Maven lifecycle.
Configure Maven Surefire Plugin so tests run with JUnit 5.

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

At this point, `pom.xml` contains the `properties`, `dependencies`, and `build` sections.

Use the following full file to verify your `pom.xml`.

<details>
  <summary>Final <code>pom.xml</code></summary>

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.example</groupId>
  <artifactId>hello-maven</artifactId>
  <version>1.0.0-SNAPSHOT</version>

  <properties>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>

  <dependencies>
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter</artifactId>
      <version>5.13.1</version>
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

</details>

## 7. Add tests

Create `src/test/java/com/example/AppTest.java`.

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

Run tests with the following command.

```sh
mvn test
```

If the configuration is correct, Maven compiles the code and executes the test successfully.
