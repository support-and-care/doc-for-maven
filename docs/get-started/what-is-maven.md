# What is Maven (for)?

Apache Maven is a free, open-source build tool, primarily used to build Java applications.
It is one of the most widely used build tools in the Java ecosystem and is designed to be easy to use, even in complex enterprise scenarios.

In short: instead of writing and maintaining a custom build script for every project, the project's structure and dependencies are described in a single file (`pom.xml`), and Maven figures out how to build it.

## What Maven does for you

A lot of tasks have to be done to build a software project, for example compiling sources, running tests, packaging the result, and managing third-party libraries.
Maven automates these tasks and performs them in a consistent, predefined way, so that they do not have to be solved again for every project.

### 1. It builds your project

Maven compiles the code, runs the tests, and packages the result as an archive.
To perform all of these steps, only one command is needed:

```sh
mvn package
```

These steps run in a fixed, predictable order called the [build lifecycle](https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html).
No custom build script is required, because Maven already knows the steps.

### 2. It manages your dependencies

Almost every real project uses third-party libraries.
Instead of downloading the required files by hand and checking them into the repository, Maven handles this.
Once the required libraries are declared in `pom.xml`, Maven will:

- download each library from a central repository (such as [Maven Central](https://search.maven.org/)),
- download any other library **that** library needs (its *transitive* dependencies),
- cache it locally so it is not re-downloaded every time it is needed,
- make it available to the compiler, tests, and packaging step.

### 3. It gives every project the same shape

Maven follows a [standard directory and project layout](https://maven.apache.org/guides/introduction/introduction-to-the-standard-directory-layout.html).
Following the principle of convention over configuration, this makes it easy to switch between Maven projects, because the structure is always familiar.

### 4. It is extended through plugins

The actual work is performed by **plugins**.
Maven ships with a rich set of plugins, covering the most needed functionality such as compiling, running tests, and packaging archives.
In addition to that, the Maven community provides plugins for almost anything else that might be needed, including code quality checks, test coverage, container image builds, and deployment.

## Problems Maven solves

When working on a Java project without a proper build tool, some of these questions may sound familiar.
Maven is designed to solve them:

- **"How do I build this project?"**
  The build is portable and produces the same result on every machine, so the project can be built with a single `mvn package` command, the same way on every developer machine and on the CI server.
- **"Do I have all the libraries I need, and in which versions?"**
  Maven downloads them, including the libraries those libraries depend on, with versions pinned in `pom.xml` and resolved the same way on every machine and CI server.
- **"Where does source code belong? Where are tests stored? Where is everything in this project?"**
  Maven uses a standard directory layout, so the project structure is always familiar, even when joining a new team.
- **"How do I share my library with other projects?"**
  Maven can publish the build output to a repository such as [Maven Central](https://search.maven.org/), which makes it easy to share libraries with the wider Java community.

## When Maven is a good fit

Maven is a good choice when the following are needed:

- a portable build that behaves the same on every machine, including CI servers,
- automatic dependency resolution from public or private repositories,
- a conventional project layout that other tools (IDEs, CI systems, code-quality tools) already understand,
- a large ecosystem of ready-made plugins,
- support for projects of any size, from a single library to a large enterprise application.

## What Maven is *not*

To avoid surprises later, it helps to know what Maven is **not**:

- It is **not an IDE**. All modern IDEs integrate Maven out of the box.
- It is **not a CI server**. Maven runs the build; the CI server runs Maven. Maven is also not a deployment tool: in the past, it was sometimes misused to distribute build artifacts to production, which is not its purpose.

## Next steps

With a clear picture of Maven's role and purpose, the next step is to install it and run a first build.

[Continue: Download and install Maven →](install-maven.md)
