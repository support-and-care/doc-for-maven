# What is Maven (for)?

Apache Maven is a free, open-source **build tool for Java and other
JVM-based projects**. You describe your project in a single file
(`pom.xml`), and Maven takes care of compiling your code, running your
tests, packaging the result, and pulling in any libraries you depend on.

In short: instead of writing and maintaining a custom build script for
every project, you tell Maven *what* your project is, and it figures out
*how* to build it.

## What Maven does for you

Most Java projects need to do roughly the same things over and over:
compile sources, run tests, bundle the output into a JAR or WAR, and
fetch third‑party libraries. Maven solves these tasks once, in a
consistent way, so you don't have to solve them again for every project.

### 1. It builds your project

With a single command, Maven will compile your code, run your unit
tests, and package the result as a JAR, WAR, or another distributable
format:

```sh
mvn package
```

You don't need to write a build script Maven already knows the steps.
These steps are called the [build
lifecycle](https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html)
and run in a fixed, predictable order (validate, compile, test, package,
verify, install, deploy).

### 2. It manages your dependencies

Almost every real project uses third-party libraries. Instead of
downloading JAR files by hand and checking them into your repository,
you declare what you need in `pom.xml`:

```xml
<dependency>
  <groupId>org.junit.jupiter</groupId>
  <artifactId>junit-jupiter-api</artifactId>
  <version>5.11.0</version>
  <scope>test</scope>
</dependency>
```

Maven will then:

- download that library from a central repository (such as [Maven
  Central](https://search.maven.org/)),
- download anything **that** library needs (its *transitive*
  dependencies),
- cache it locally so it isn't re-downloaded for every build,
- make it available to your compiler, tests, and packaging step.

### 3. It gives every project the same shape

Maven projects follow a [standard directory
layout](https://maven.apache.org/guides/introduction/introduction-to-the-standard-directory-layout.html):
source code lives in `src/main/java`, tests in `src/test/java`, build
output in `target/`, and so on.

Once you've learned this layout, you can drop into any other Maven
project your own, your team's, or an open source one on GitHub and
immediately know where to look.

### 4. It is extended through plugins

The actual work (compiling Java, running tests, building a JAR, signing
artifacts, generating a site, …) is performed by **plugins**. Maven
ships with a rich set of core plugins, and the wider ecosystem provides
plugins for almost anything else you might need: code quality checks,
test coverage, container image builds, deployment, and so on.

You configure plugins in the same `pom.xml`, alongside your
dependencies.

## Problems Maven solves

If you have ever worked on a Java project without a proper build tool,
some of these may sound familiar. Maven is designed to solve them:

- **"How do I build this project?"**
  Anyone who can install Maven can build the project with `mvn package`.
  No hidden scripts, no "ask Noah, he knows".
- **"Which version of which library do we use?"**
  Versions are pinned in `pom.xml` and resolved the same way on every
  machine and CI server.
- **"Do I have all the JARs I need?"**
  Maven downloads them for you, including the libraries your libraries
  depend on.
- **"Where do tests go? How do I run them?"**
  Tests live in `src/test/java` and run as part of the build.
- **"How do I share my library with other projects?"**
  Maven can publish your build output to a repository so other projects
  can depend on it, just like they depend on any other library.
- **"I just joined a new team, Where is everything?"**
  If the project uses Maven, the layout is already familiar.

## When Maven is a good fit

Maven works well when you want:

- a build that behaves the same on your laptop, your colleague's laptop,
  and CI,
- automatic dependency resolution from public or private repositories,
- a conventional project layout that other tools (IDEs, CI systems,
  code-quality tools) already understand,
- a large ecosystem of ready-made plugins,
- support for projects of any size, from a single library to a large
  multi-module application.

## What Maven is *not*

To avoid surprises later, it helps to know what Maven is **not**:

- It is **not an IDE**. You can use Maven from any editor or IDE,
  most major IDEs (IntelliJ IDEA, Eclipse, VS Code, NetBeans) understand
  `pom.xml` natively.
- It is **not a CI/CD server**. Maven runs your build, tools like
  Jenkins, GitHub Actions, or GitLab CI decide *when* and *where* to run
  it.
- It is **not limited to Java**. Maven is most commonly used for Java,
  but plugins exist for Kotlin, Scala, Groovy, and other JVM languages,
  and for non-JVM tasks such as building container images or front-end
  assets.

## Ready to try it?

Now that you have a feel for what Maven is and what it's good for, the
next step is to install it and run your first build.

[Continue: Download and install Maven →](install-maven.md)
