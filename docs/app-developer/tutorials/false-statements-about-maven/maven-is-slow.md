# False statements about Maven: Maven is slow

The claim that Maven is slow mostly comes from comparisons with Gradle, many of them published by the Gradle team.
Whether it holds depends on what was measured: Gradle has an edge for incremental builds, but not in general.
A Maven build spends little time on anything other than the work you asked for, and parallel builds, a daemon and a build cache are available for Maven as well.
Getting that speed doesn't require changes to the project, while keeping a Gradle build fast is ongoing work.

## Benchmarks

A published comparison between the two tools often measures an incremental Gradle build with a running daemon and a populated build cache against a clean `mvn install` that starts from a cold JVM.
Such a setup mainly measures the effect of the daemon and the cache, so the result tells you little about how the tools compare when both are configured the same way.

Before you trust a benchmark, check how it was set up:

| Question | Why it matters |
| --- | --- |
| Was the JVM cold or warm on both sides? | A running daemon skips JVM startup and JIT warm-up. |
| Was it a clean build or an incremental one? | Incremental builds favor whichever tool has better up-to-date checks and caching. |
| Was a build cache enabled, and on which side? | A cache hit skips the work. |
| Did both builds do the same work? | `gradle build` and `mvn install` run different sets of tasks. |
| How large was the project? | Overhead that is negligible for ten subprojects can matter for three hundred. |

!!! tip "Look at your own build first"
    Few teams keep a project in two build tools long enough to compare them fairly.
    Finding out where your own Maven build spends its time is more useful.
    Add [maven-profiler](https://github.com/jcgay/maven-profiler) to `.mvn/extensions.xml`, run your build with `-Dprofile`, and read the per-plugin report it writes to `.profiler`.
    Usually a few plugins or test suites account for most of the time, and often that is the same work Gradle would have to do.

That being said, there are cases where Gradle is faster.
Its up-to-date checks work per task and its compilation is incremental at the class level.
When you change one file and rebuild, Gradle therefore often does less work than Maven, where plugins mostly decide per subproject whether to rebuild.
On a developer machine where builds are run many times a day with small changes in between, this difference can be noticeable.
For clean builds and on CI runners that start from scratch, it's mostly negligible.

## Per-build overhead

When you run `mvn`, Maven starts a JVM, reads the POMs, works out which plugin goals to run, and runs them.
Since a POM is an XML file rather than a program, there is nothing to compile before the build can start, and apart from JVM startup there is little fixed cost per build.

Gradle build scripts are Groovy or Kotlin code, so before Gradle can run any task it has to compile the scripts and execute them to configure the project.
Compiling Kotlin DSL scripts in particular takes noticeable time.
The first build with a new Gradle version runs several one-time initializations (such as generating the Gradle API jar) and starts a daemon process.
Gradle avoids most of this cost on later runs through the daemon, its script cache and the configuration cache, but in a fresh environment such as a new CI runner it has to be done every time.

| Per-build overhead | Maven | Gradle |
| --- | --- | --- |
| JVM startup | Yes | Yes, once per daemon |
| Compile build scripts | No | Yes, cached after the first run |
| Run build logic to configure the project | No, the POM is read as data | Yes, unless the configuration cache applies |
| Generate jars for a new tool version | No | Yes, once per version |

## Download size

Many CI setups start every job on a fresh runner, and unless you cache the tool and the local repository, each job downloads everything again.

The Maven distribution is about 10 MB because it contains only the core, and plugins such as the compiler, Surefire and jar plugins are fetched on first use.
Including those, a basic Maven build downloads about 30 MB in total, while the Gradle distribution alone is about 135 MB.[^sizes]

[^sizes]: Sizes are for Maven 3.10.0 and Gradle 9.9.0, measured in November 2026.
The plugin figure comes from running `mvn package` on a small JUnit 5 project with an empty local repository.

## Parallel builds

In a project with several subprojects, Maven can build subprojects that don't depend on each other at the same time.
The `-T` option sets the number of threads, either as a fixed number or relative to the available CPU cores:

```bash
mvn -T 1C verify
```

Gradle also runs tasks in parallel only when you pass `--parallel`, so in both tools this is something you have to turn on.

The two tools differ in how finely they schedule the work.
Gradle schedules individual tasks, so a subproject can start compiling as soon as the subprojects it depends on have been compiled, while their tests may still be running.
Maven's default builder runs a subproject through all requested phases, including its tests, before any subproject that depends on it can start, which leaves Gradle more to run in parallel.
Maven 4 ships a builder (selected with `-b concurrent`) that works phase by phase instead and lets a dependent subproject start as soon as its dependencies are ready.
For Maven 3, the [maven-turbo-builder](https://github.com/maven-turbo-reactor/maven-turbo-builder) extension does something similar: it runs `package` before `test` and starts dependent subprojects as soon as their dependencies are packaged.

## The Maven daemon

The [Apache Maven Daemon](https://github.com/apache/maven-mvnd) (`mvnd`) keeps a Maven process running between builds in the same way the Gradle daemon does.
The JVM stays warm, the JIT has already optimized the hot code, and plugin classloaders are reused instead of being created for every build.
`mvnd` also turns on parallel builds by default.

You use it in place of the `mvn` command:

```bash
mvnd verify
```

The first build takes about as long as a regular Maven build because the daemon has to start, and the speedup shows from the second build on.

## The build cache

The [Maven Build Cache Extension](https://maven.apache.org/extensions/maven-build-cache-extension/) stores the outputs of each subproject, and when a subproject's inputs haven't changed, Maven restores its outputs from the cache instead of building it again.
The cache can be local, or remote so that CI and developers share results.

To enable it, add the extension to `.mvn/extensions.xml` in your project root:

```xml
<extensions>
  <extension>
    <groupId>org.apache.maven.extensions</groupId>
    <artifactId>maven-build-cache-extension</artifactId>
    <version>1.3.0</version>
  </extension>
</extensions>
```

After that, a second `mvn verify` with no changes restores every subproject from the cache.
The extension's documentation covers remote caches and how to tune which inputs count.

## Maintenance effort

Gradle's performance features such as the configuration cache and isolated projects place restrictions on what build scripts and plugins may do.
Getting a large build to comply means auditing plugins and rewriting custom build logic, and the build has to stay compliant as it evolves.

A Maven build has no build logic to keep compatible.
The POM declares which plugins run and with which configuration, and the daemon and build cache work on top of that without changes to the project.
The POM format itself is versioned through `<modelVersion>`, and a newer Maven keeps building projects that declare an older version.
You can upgrade Maven first and raise the model version later, when you want the features that come with it.

## Conclusion

Measured on equal terms, Maven is not slow.
Starting a JVM and reading the POMs is nearly all the overhead a Maven build has, and most of the speed difference people cite comes from Gradle's daemon and build cache rather than from the tools themselves.
Maven has both, along with parallel builds, and none of them require changes to the project.
On fresh CI runners its much smaller download is an advantage on top.
Gradle can be faster for incremental builds on a developer machine, but that advantage depends on keeping the build compatible with its caching features.
If build time is your reason for considering a switch, profile your current build first to see where the time goes.

## Next steps

- [How the build lifecycle works](../../key-concepts/how-build-lifecycle-works.md): what Maven does in each phase, which helps you see where your build spends its time
- [Maven Daemon](https://github.com/apache/maven-mvnd): installation options and configuration
- [Maven Build Cache Extension](https://maven.apache.org/extensions/maven-build-cache-extension/): setting up a remote cache and tuning cache inputs
