# False statements about Maven: Do (not) use 'mvn clean install'

When asking developers which Maven command they use to build their applications, a large amount of them answer `mvn clean install`.
If you then ask them "why" they use this command, their response is often something like "I learned this from a training / online tutorial".

However, in most situation you don't want to use `mvn clean install`, because it does mean that it recreates and effects your regular build in a negative way:
* It removes every possibility to reuse any previous generated/compiled/packaged file,
* it executes unnecessary IO operations by copying files, and 
* it (with Maven 3 default plugin values) makes artifacts of a project with multiple subprojects available to other builds - regardless if the whole build was successful or not.

But why do so many sources suggest it then?
Because it is a workaround for a long existing bug in Maven 2 and 3, which finally got fixed in Maven 4.
The bug was in Maven's reactor component, which resolves subprojects of a project and calculates the order in which they are need to be built to fulfill project own dependencies. 
It occurred, when you restarted a failed build of a project with multiple subprojects:
Let's say you have a project with subproject A and B, where B is dependent on A and run `mvn verify`.
When the build of A was successful, but the one of B was not, Maven suggests to fix the build and resume at rebuilding B.
Bug due the bug Maven "forgot" that also A is needed and fails again, unable to resolve A.


