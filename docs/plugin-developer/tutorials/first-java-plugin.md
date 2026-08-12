# Write your first Java plugin

<!-- markdownlint-disable MD046 -->
<!-- Content tabs (===) and admonitions indent body text; markdownlint misreports that as indented code blocks. -->

## What you'll learn

In this tutorial you'll build a Maven 3 plugin in Java with a single goal that prints a greeting.
By the end you'll have installed the plugin in your local repository and run it from the command line.

You will:

- Create a Maven 3 plugin project
- Write a Mojo with a custom goal
- Install the plugin locally and run it from the command line
- Optionally configure a Mojo parameter

## Prerequisites

Before starting this tutorial, you should have:

- Maven 3.9 or newer installed and available on your `PATH` ([Installing Apache Maven](../../about/installation.md))
- A JDK that can compile Java 17 sources (JDK 17 or newer)
- Completed a basic Maven build at least once ([Your first Maven build in 5 minutes](../../app-developer/getting-started/first-build.md))

You don't need to know anything about Maven plugins yet, that's what we're here to learn.

## Step 1: Create the plugin project layout

Maven plugins use the same standard directory layout as other Java projects.
Create a folder for the plugin, the Java package path, and an empty `pom.xml`:

=== "macOS / Linux"

    ```sh
    mkdir -p hello-maven-plugin/src/main/java/sample/plugin \
      && touch hello-maven-plugin/pom.xml
    ```

=== "Windows (PowerShell)"

    ```powershell
    $root = "hello-maven-plugin"
    New-Item -ItemType Directory -Path "$root/src/main/java/sample/plugin" -Force | Out-Null
    New-Item -ItemType File -Path "$root/pom.xml" -Force | Out-Null
    ```

**Verify:** list the tree with `ls -R hello-maven-plugin` (macOS / Linux) or `tree hello-maven-plugin` if you have it.
It should match:

```text
hello-maven-plugin/
├── pom.xml
└── src
    └── main
        └── java
            └── sample
                └── plugin
```

## Step 2: Declare a Maven plugin POM

Open `hello-maven-plugin/pom.xml` and give Maven the coordinates, packaging, and APIs this plugin needs:

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>sample.plugin</groupId>
  <artifactId>hello-maven-plugin</artifactId>
  <version>1.0-SNAPSHOT</version>
  <packaging>maven-plugin</packaging>

  <name>Hello Maven Plugin</name>

  <properties>
    <maven.compiler.release>17</maven.compiler.release>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.version>3.9.9</maven.version>
    <maven.plugin.tools.version>3.15.2</maven.plugin.tools.version>
  </properties>

  <dependencies>
    <dependency>
      <groupId>org.apache.maven</groupId>
      <artifactId>maven-plugin-api</artifactId>
      <version>${maven.version}</version>
      <scope>provided</scope>
    </dependency>
    <dependency>
      <groupId>org.apache.maven.plugin-tools</groupId>
      <artifactId>maven-plugin-annotations</artifactId>
      <version>${maven.plugin.tools.version}</version>
      <scope>provided</scope>
    </dependency>
  </dependencies>

  <build>
    <pluginManagement>
      <plugins>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-plugin-plugin</artifactId>
          <version>${maven.plugin.tools.version}</version>
        </plugin>
      </plugins>
    </pluginManagement>
  </build>
</project>
```

Here's what the important parts do:

- `maven-plugin` packaging applies the plugin build lifecycle, including plugin descriptor generation.
- `maven-plugin-api` provides `AbstractMojo` and related Maven 3 APIs.
- `maven-plugin-annotations` provides `@Mojo` and `@Parameter`.
- `provided` scope keeps those APIs off the plugin JAR because Maven supplies them at runtime.
- Pinning `maven-plugin-plugin` in `pluginManagement` sets which Plugin Tools version that lifecycle uses for descriptor generation.

!!! warning "Plugin naming and the Maven trademark"
    Name community plugins `hello-maven-plugin` (the `${prefix}-maven-plugin` convention).
    Avoid `maven-${prefix}-plugin`.
    That naming pattern is reserved for official Apache Maven plugins with groupId `org.apache.maven.plugins`.

**Verify:** from `hello-maven-plugin/`, run:

```sh
mvn validate
```

You should see `BUILD SUCCESS`.

**If you see an unknown packaging type:** confirm `<packaging>maven-plugin</packaging>` is spelled exactly that way.

## Step 3: Write your first Mojo

A *[Mojo](../key-concepts/plugin-architecture.md)* is the Java implementation of a Maven goal.
A plugin can package one or more Mojos.
Create `src/main/java/sample/plugin/GreetingMojo.java`:

```java
package sample.plugin;

import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugins.annotations.Mojo;

/**
 * Says "Hi" to the user.
 */
@Mojo(name = "sayhi")
public class GreetingMojo extends AbstractMojo {

    @Override
    public void execute() throws MojoExecutionException {
        getLog().info("Hello, world.");
    }
}
```

Let's walk through what this does.
Extending `AbstractMojo` gives you logging and the rest of the goal infrastructure.
You implement `execute()`.
`@Mojo(name = "sayhi")` registers this class as the `sayhi` goal.
`getLog().info(...)` writes a user-visible message.
Throwing `MojoExecutionException` fails the build with `BUILD FAILURE`.

**Verify:** from `hello-maven-plugin/`, compile the Mojo:

```sh
mvn compile
```

You should see `BUILD SUCCESS`.

**If compilation fails on `AbstractMojo` or `@Mojo`:** check that both dependencies from Step 2 are inside `<dependencies>` and that their versions resolve from Maven Central.

## Step 4: Install the plugin

Install the plugin into your local repository so other projects (and the command line) can resolve it:

```sh
mvn install
```

A successful run ends with `BUILD SUCCESS` and installs `sample.plugin:hello-maven-plugin:1.0-SNAPSHOT`:

```text
[INFO] --- maven-install-plugin:...:install (default-install) @ hello-maven-plugin ---
[INFO] Installing .../hello-maven-plugin-1.0-SNAPSHOT.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```

**Verify:** confirm the descriptor and the local repository install exist:

```sh
ls target/classes/META-INF/maven/plugin.xml
ls ~/.m2/repository/sample/plugin/hello-maven-plugin/1.0-SNAPSHOT/
```

You should see `plugin.xml` and a JAR named `hello-maven-plugin-1.0-SNAPSHOT.jar`.

**If you see `No plugin descriptor found` later when invoking the goal:** re-run `mvn clean install` and check that `target/classes/META-INF/maven/plugin.xml` exists after the build.

## Step 5: Run the `sayhi` goal

Stay inside `hello-maven-plugin/` and invoke the goal with its full coordinates:

```sh
mvn sample.plugin:hello-maven-plugin:1.0-SNAPSHOT:sayhi
```

A successful run prints the greeting and ends in `BUILD SUCCESS`:

```text
[INFO] --- hello:1.0-SNAPSHOT:sayhi (default-cli) @ hello-maven-plugin ---
[INFO] Hello, world.
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```

The coordinate form is `groupId:artifactId:version:goal`.
For predictable results in this tutorial, keep the version in the command.
You can omit the version and let Maven resolve which plugin version to use:

```sh
mvn sample.plugin:hello-maven-plugin:sayhi
```

**If Maven cannot resolve the plugin:** confirm Step 4 finished with `BUILD SUCCESS`, then check `~/.m2/repository/sample/plugin/hello-maven-plugin/1.0-SNAPSHOT/` for the installed JAR and POM.

## Step 6: Add a configurable parameter

The goal works, but it always prints the same text.
Add a `greeting` parameter so callers can change the message:

```java
package sample.plugin;

import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugins.annotations.Mojo;
import org.apache.maven.plugins.annotations.Parameter;

/**
 * Says "Hi" to the user.
 */
@Mojo(name = "sayhi")
public class GreetingMojo extends AbstractMojo {

    /**
     * The greeting to display.
     */
    @Parameter(property = "sayhi.greeting", defaultValue = "Hello, world.")
    private String greeting;

    @Override
    public void execute() throws MojoExecutionException {
        getLog().info(greeting);
    }
}
```

`@Parameter` marks the field as Mojo configuration.
`defaultValue` is used when the caller does not set the parameter.
`property` exposes a user property so you can override it with `-D` on the command line.

Reinstall, then run with a custom greeting:

```sh
mvn install
mvn sample.plugin:hello-maven-plugin:1.0-SNAPSHOT:sayhi -Dsayhi.greeting="Hello, Maven plugin developers!"
```

**Verify:** the log contains:

```text
[INFO] Hello, Maven plugin developers!
```

## Step 7: Shorten the command line (optional)

Typing the full coordinates every time gets old quickly.
The artifactId `hello-maven-plugin` follows the `${prefix}-maven-plugin` convention, so Maven derives the prefix `hello`.
Maven does not search arbitrary plugin groupIds for prefix resolution unless they are listed in `pluginGroups`.
Add `sample.plugin` to `~/.m2/settings.xml` so the `hello` prefix can resolve to this plugin.

Add this block to your existing settings file.
Do not replace the whole file:

```xml
<settings>
  <!-- ... -->
  <pluginGroups>
    <pluginGroup>sample.plugin</pluginGroup>
  </pluginGroups>
</settings>
```

Then run:

```sh
mvn hello:sayhi -Dsayhi.greeting="Hi from a short prefix!"
```

**Verify:** the log contains:

```text
[INFO] Hi from a short prefix!
```

**If you see `No plugin found for prefix 'hello'`:** Maven is only searching the default plugin groups.
Confirm `sample.plugin` is listed under `<pluginGroups>` in the settings file Maven is using.

## Step 8: Configure the parameter in the POM (optional)

You can set the same parameter in `pom.xml` instead of `-D`.
Add a `<plugins>` block inside the existing `<build>` section, next to `<pluginManagement>`:

```xml
  <build>
    <pluginManagement>
      <!-- ... unchanged ... -->
    </pluginManagement>
    <plugins>
      <plugin>
        <groupId>sample.plugin</groupId>
        <artifactId>hello-maven-plugin</artifactId>
        <version>1.0-SNAPSHOT</version>
        <configuration>
          <greeting>Welcome</greeting>
        </configuration>
      </plugin>
    </plugins>
  </build>
```

The configuration element name (`greeting`) matches the Mojo field name.

**Verify:** from `hello-maven-plugin/`, run without `-D`:

```sh
mvn sample.plugin:hello-maven-plugin:1.0-SNAPSHOT:sayhi
```

The log should contain:

```text
[INFO] Welcome
```

An explicit `<greeting>` value in the POM is the configured value for this project.
Use `-Dsayhi.greeting=...` when the parameter is not set literally in the POM, as in Step 6.
A literal `<greeting>` here is not overridden by that `-D` property.

## The complete files

Since you edited `pom.xml` in Step 2 and `GreetingMojo.java` in Steps 3 and 6, here are the full files for the required path so you can compare against your own.
The optional `pluginGroups` settings from Step 7 and the optional `<plugins>` configuration from Step 8 are omitted.

### `pom.xml`

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>sample.plugin</groupId>
  <artifactId>hello-maven-plugin</artifactId>
  <version>1.0-SNAPSHOT</version>
  <packaging>maven-plugin</packaging>

  <name>Hello Maven Plugin</name>

  <properties>
    <maven.compiler.release>17</maven.compiler.release>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.version>3.9.9</maven.version>
    <maven.plugin.tools.version>3.15.2</maven.plugin.tools.version>
  </properties>

  <dependencies>
    <dependency>
      <groupId>org.apache.maven</groupId>
      <artifactId>maven-plugin-api</artifactId>
      <version>${maven.version}</version>
      <scope>provided</scope>
    </dependency>
    <dependency>
      <groupId>org.apache.maven.plugin-tools</groupId>
      <artifactId>maven-plugin-annotations</artifactId>
      <version>${maven.plugin.tools.version}</version>
      <scope>provided</scope>
    </dependency>
  </dependencies>

  <build>
    <pluginManagement>
      <plugins>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-plugin-plugin</artifactId>
          <version>${maven.plugin.tools.version}</version>
        </plugin>
      </plugins>
    </pluginManagement>
  </build>
</project>
```

### `src/main/java/sample/plugin/GreetingMojo.java`

```java
package sample.plugin;

import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugins.annotations.Mojo;
import org.apache.maven.plugins.annotations.Parameter;

/**
 * Says "Hi" to the user.
 */
@Mojo(name = "sayhi")
public class GreetingMojo extends AbstractMojo {

    /**
     * The greeting to display.
     */
    @Parameter(property = "sayhi.greeting", defaultValue = "Hello, world.")
    private String greeting;

    @Override
    public void execute() throws MojoExecutionException {
        getLog().info(greeting);
    }
}
```

## What you learned

You created a Maven 3 plugin project, implemented a Mojo with `@Mojo` and `@Parameter`, installed it locally, and ran the `sayhi` goal from the command line.

## Next steps

<div class="grid cards" markdown>

- :material-flask-outline: **[Test a development version of a plugin](../tutorials/test-development-plugin.md)**

    Run automated tests against the plugin before you release it.

- :material-file-document-outline: **[Document a plugin to the standard](../how-to/document-plugin.md)**

    Generate user-facing docs from the annotations you just added.

- :material-magnify: **[Handle plugin prefix resolution](../how-to/plugin-prefix-resolution.md)**

    Control how short names like `hello:sayhi` map to artifacts.

- :material-puzzle-outline: **[Plugin architecture & the Mojo model](../key-concepts/plugin-architecture.md)**

    Deepen the mental model behind goals, descriptors, and classloading.

- :material-book-open-outline: **[Mojo API reference](../reference/mojo-api-reference.md)**

    Look up annotations and APIs as you add more goals.

</div>
