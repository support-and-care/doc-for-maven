# Download and Install Apache Maven

Maven is a command-line tool. Installing it means putting the `mvn`
command on your `PATH` so you can run it from any terminal.

This page walks you through:

1. checking that you have a working Java installation,
2. installing Maven (using a package manager or the official archive),
3. verifying that everything works.

If you are in a hurry and already know your way around your operating
system, jump straight to the [package-manager](#install-with-a-package-manager)
or [manual install](#install-from-the-binary-archive) section.

## Prerequisites: a working JDK

Maven is itself a Java application, so you need a **Java Development
Kit (JDK)** installed before you install Maven.

| Maven version | Required JDK to run Maven |
|---|---|
| Maven 3.9.x (current stable) | JDK 8 or later |
| Maven 4.x (preview)          | JDK 17 or later |

!!! tip "JDK vs. JRE"
    You need a JDK, not just a JRE. The JDK includes the tools (such as
    `javac`) that Maven uses to compile your projects.

You can use any modern JDK distribution, for example
[Eclipse Temurin](https://adoptium.net/),
[Amazon Corretto](https://aws.amazon.com/corretto/),
[Azul Zulu](https://www.azul.com/downloads/),
[Microsoft Build of OpenJDK](https://learn.microsoft.com/en-us/java/openjdk/),
or the [Oracle JDK](https://www.oracle.com/java/technologies/downloads/).

### Check your JDK

Open a new terminal and run:

```sh
java -version
javac -version
```

You should see something similar to:

```text
openjdk version "21.0.4" 2024-07-16 LTS
javac 21.0.4
```

If either command is *not* found, install a JDK first and then come back.

### Set `JAVA_HOME` (recommended)

Maven looks for Java by checking the `JAVA_HOME` environment variable
first, then falling back to the `java` executable on your `PATH`.
Setting `JAVA_HOME` explicitly makes your setup predictable and easier
to debug.

=== "macOS / Linux (bash, zsh)"

    Add the following to your shell profile (`~/.zshrc`, `~/.bashrc`,
    `~/.profile`, depending on your shell), replacing the path with
    your actual JDK location:

    ```sh
    export JAVA_HOME=/path/to/your/jdk
    export PATH="$JAVA_HOME/bin:$PATH"
    ```

    On macOS, you can let the system locate your JDK:

    ```sh
    export JAVA_HOME=$(/usr/libexec/java_home)
    ```

    Reload the shell (`source ~/.zshrc`) or open a new terminal.

=== "Windows (PowerShell)"

    Set the variable for your user account:

    ```powershell
    [Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk-21", "User")
    ```

    You can also set it through **Settings → System → About →
    Advanced system settings → Environment Variables**.

    Open a new PowerShell or Command Prompt window so the change takes
    effect.

## Install Maven

There are two common ways to install Maven:

- **With a package manager.** This is the quickest path on most
  systems and lets the package manager handle upgrades.
- **From the official binary archive.** This gives you full control
  over the exact version and where Maven lives on disk.

Pick whichever fits your environment. Both produce a working `mvn`
command.

### Install with a package manager

=== "macOS"

    With [Homebrew](https://brew.sh/):

    ```sh
    brew install maven
    ```

    With [SDKMAN!](https://sdkman.io/) (handy if you also manage
    multiple JDKs):

    ```sh
    sdk install maven
    ```

    With [MacPorts](https://www.macports.org/):

    ```sh
    sudo port install maven3
    ```

=== "Linux"

    The exact command depends on your distribution's package manager:

    ```sh
    # Debian / Ubuntu
    sudo apt update
    sudo apt install maven

    # Fedora / RHEL / CentOS Stream (dnf)
    sudo dnf install maven

    # Older RHEL / CentOS (yum)
    sudo yum install maven
    ```

    !!! note "Distro packages can lag behind"
        Linux distributions sometimes ship an older Maven release. If
        you need a specific version, prefer the
        [binary archive](#install-from-the-binary-archive) or
        [SDKMAN!](https://sdkman.io/).

=== "Windows"

    With [Chocolatey](https://chocolatey.org/):

    ```powershell
    choco install maven
    ```

    With [Scoop](https://scoop.sh/):

    ```powershell
    scoop install main/maven
    ```

After the package manager finishes, skip ahead to
[Verify the installation](#verify-the-installation).

### Install from the binary archive

This method works on any operating system and gives you the exact
version published by the Apache Maven project.

#### 1. Download the archive

Go to the [Maven download page](https://maven.apache.org/download.html)
and download the latest **binary** distribution:

- `apache-maven-<version>-bin.zip` — works on every platform, easiest
  on Windows,
- `apache-maven-<version>-bin.tar.gz` — convenient on macOS and Linux.

!!! tip "Verify the download (optional but recommended)"
    For production setups, verify the download against the published
    [PGP signatures and checksums](https://www.apache.org/info/verification.html)
    using the public [KEYS](https://downloads.apache.org/maven/KEYS)
    file.

#### 2. Extract the archive

Extract it to a directory you control. A few common conventions:

- macOS / Linux: `/opt/apache-maven-<version>` or
  `~/tools/apache-maven-<version>`
- Windows: `C:\Program Files\Apache\apache-maven-<version>` or
  `C:\Tools\apache-maven-<version>`

=== "macOS / Linux"

    ```sh
    sudo tar -xzf apache-maven-3.9.16-bin.tar.gz -C /opt
    ```

    This creates `/opt/apache-maven-3.9.16`.

=== "Windows (PowerShell)"

    ```powershell
    Expand-Archive -Path apache-maven-3.9.16-bin.zip -DestinationPath C:\Tools
    ```

    This creates `C:\Tools\apache-maven-3.9.16`.

#### 3. Add Maven to your `PATH`

Maven needs its `bin` directory on your `PATH` so the `mvn` command is
available everywhere.

=== "macOS / Linux (bash, zsh)"

    Add these lines to your shell profile (`~/.zshrc`, `~/.bashrc`,
    `~/.profile`):

    ```sh
    export MAVEN_HOME=/opt/apache-maven-3.9.16
    export PATH="$MAVEN_HOME/bin:$PATH"
    ```

    Reload your shell, for example:

    ```sh
    source ~/.zshrc
    ```

=== "Windows (PowerShell)"

    Set the environment variables for your user. The snippet below is
    safe to re-run. It only appends to `Path` if Maven is not already
    there:

    ```powershell
    $mavenHome = "C:\Tools\apache-maven-3.9.16"
    [Environment]::SetEnvironmentVariable("MAVEN_HOME", $mavenHome, "User")

    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($userPath -notlike "*$mavenHome\bin*") {
      [Environment]::SetEnvironmentVariable("Path", "$userPath;$mavenHome\bin", "User")
    }
    ```

    Or use the GUI: **Settings → System → About → Advanced system
    settings → Environment Variables**, then add `MAVEN_HOME` and
    append `%MAVEN_HOME%\bin` to `Path`.

    Open a new terminal so the changes take effect.

## Verify the installation

Open a **new** terminal (so it picks up your new environment variables)
and run:

```sh
mvn -v
```

You should see output similar to this:

```text
Apache Maven 3.9.16 (2bdd9fddda4b155ebf8000e807eb73fd829a51d5)
Maven home: /opt/apache-maven-3.9.16
Java version: 21.0.4, vendor: Eclipse Adoptium, runtime: /opt/jdk-21
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "6.8.0", arch: "amd64", family: "unix"
```

If you see this, **Maven is installed and ready to use**.

## Troubleshooting

??? failure "`mvn: command not found` (or `'mvn' is not recognized...`)"
    The `mvn` command is not on your `PATH`. Confirm that:

    - the `bin/` directory inside your Maven installation is on `PATH`,
    - you opened a **new** terminal after editing your environment
      variables.

    Run `echo $PATH` (macOS/Linux), `echo $env:PATH` (Windows
    PowerShell), or `echo %PATH%` (Windows Command Prompt) to inspect
    your current path.

??? failure "`JAVA_HOME is not defined correctly`"
    Maven cannot find your JDK. Check that:

    - `JAVA_HOME` points to a JDK directory (not a JRE, and not the
      `bin/` subdirectory),
    - the directory exists and contains `bin/java` (or `bin\java.exe`
      on Windows).

    Run `echo $JAVA_HOME` (macOS/Linux), `echo $env:JAVA_HOME`
    (Windows PowerShell), or `echo %JAVA_HOME%` (Windows Command
    Prompt) to inspect the current value.

??? failure "Wrong Java version is used"
    `mvn -v` prints the JDK Maven is actually using. If it is not the
    one you expect, your `JAVA_HOME` or `PATH` is pointing at a
    different JDK. Update `JAVA_HOME` and open a new shell.

??? question "Behind a corporate proxy?"
    If Maven cannot download dependencies on first use, you may need
    to configure a proxy in `~/.m2/settings.xml`. See the
    [Guide to Configuring Maven](https://maven.apache.org/guides/mini/guide-configuring-maven.html).

## What's next?

Maven is installed and verified. You are now ready to build your first
project.

[Continue: Basic project sample →](basic-project-sample.md)
