# Build Maven from source

## What you'll learn

During this tutorial, you will learn how to build the core components of Apache Maven from their sources.

## Prerequsites

This page assumes, you are familiar with Maven and Git flows in general.
Also, you should have set up your [dev-environment](../how-to/setup-dev-environment.md).

## Step 1: Setup repo tool

Maven's full source code is dispatched in more than 100 Git repos: Maven core, but also plugins or components, skins, a few svn2git read-only mirrors…

To check out full Maven source code easily, there is a simple way using the [Google repo]((https://android.googlesource.com/tools/repo)) tool and an additional Git repository for tool's manifest.

Please make sure, that *repo* is working.
The manifest will be checked out in the next step.

## Step 2: Running repo to set up Maven projects

Running *repo* ensures that all necessary components are being checked out:

```bash
mkdir maven
cd maven
repo init -u https://github.com/apache/maven-sources.git
repo sync
repo start master --all
```

## Step 3 Option 1: Build everything

Before you start the build, keep in mind that this will take some time as you are building hundreds of components and modules.

You can start the build using these commands:

```bash
mvn --fail-at-end -Prun-its verify
mvn --fail-at-end -Preporting site```
```

## Step 3 Option 2: Build a single module

Besides building the whole repo at once, you may also build smaller parts of it.

To achieve a smaller build, you have to enter the corresponding folger of that module and execute the same commands, as for option 1:

```bash
mvn --fail-at-end -Prun-its verify
mvn --fail-at-end -Preporting site```
```

## Recap

Congrats, you are now able to build Maven or at least a part of Maven from sources!
We have prepared a section about [core-components](../reference/core-component-reference.md) more details about the project structure if you are interested.
