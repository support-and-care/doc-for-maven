# False statements about Maven: Do (not) use 'mvn clean install'

When asking developers which Maven command they use to build their applications, a large amount of them answer `mvn clean install`.
If you then ask them "why" they use this command, their response is often something like "I learned this from a training / online tutorial".

However, in most situation you don't want to use `mvn clean install`, because it **can** effect your regular build in a negative way:
* It removes the possibility to reuse any previous generated/compiled/packaged file,
* it executes unnecessary IO operations by copying files, and 
* it (with Maven 3 default plugin values) makes artifacts of a project with multiple subprojects available to other builds - regardless if the whole build was successful or not.

So why do so many sources suggest it then?
The main reason: Because using `install` is a workaround for a long existing bug in Maven 2 and 3.
The bug was in Maven's reactor component, which resolves subprojects of a project and calculates the order in which they are need to be built to fulfill project own dependencies. 
It occurred, when you restarted a failed build of a project with multiple subprojects:
Let's say you have a project with subproject A and B, where B is dependent on A and run `mvn verify`.
When the build of A was successful, but the one of B was not, Maven suggests to fix the build and resume at rebuilding B.
Bug due the bug Maven "forgot" that also A is needed and fails again, unable to resolve A.
Good news: This bug got fixed and Maven 4 also introduces a project wide local repository, so this workaround is not needed anymore.

A common argument to avoid using `install` is that you "pollute" your local (user) repository by publishing partly build projects.
To tackle the problem of copying partly built projects into the local directory, you can make use of the property `installAtEnd` of the maven-install-plugin.
With this property set to `true` build artifacts are transferred to the local directory at the end of the Maven build, ensuring that the whole build was successful before publishing its result.
Another small advantage of not copying files to the local repository is that reduced IO operations saves some additional build time.

But is copying "broken" artifacts to the local repository really that bad?
Only, if they stay there for too long.
The argument to avoid using `install` to not "pollute" the local repository in general is brought up by people who never purge their local repository.
They think the local repository needs to be pristine and purging it is bad.
But it's not.
Cover this in all aspects would be too much for this article and is also covered in the article ["Never say never"](https://maveniverse.eu/blog/2025/03/17/never-say-never/) by Maven PMC Tamas Cservenak.

Of course there are scenarios where you must use `install`.
If you are working on a library or a META-POM and want to test it with other projects locally, then you need to use `install`.

Let's have a look at `clean`:
Using the `clean` goal deletes the `target`-folder and therefore all created content in it.
Generating files and compiling classes in general consume a big part of the whole build time.
So think twice if you really want to delete everything and recreate it.
Instead, in most cases you want to reuse them.
An even more improved caching is possible by using the [maven-build-cache-extension](https://maven.apache.org/extensions/maven-build-cache-extension/).

## Conclusion
Don't use `clean` and/or `install` blindly.
Choose them if you benefit from them, avoid them if you suffer from their disadvantages. 