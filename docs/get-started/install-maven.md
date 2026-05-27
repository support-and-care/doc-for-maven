# Installing Apache Maven

Apache Maven is a command-line build tool, so installing it means making the `mvn` command available from a terminal.

This guide covers three steps:

1. installing and configuring a Java Development Kit (JDK);
2. downloading and installing Maven;
3. verifying the Maven installation.

## Prerequisites: a working JDK

Maven runs on the Java platform and requires a **Java Development Kit (JDK)** to execute.
A JDK (not a JRE) is required, because Maven invokes compiler tools such as `javac` during a build.

The minimum required JDK version depends on the Maven version in use:

| Maven version | Minimum JDK |
|---|---|
| Maven 3.x | JDK 8 |
| Maven 4.x | JDK 17 |

Any modern JDK distribution is suitable.

### Verify your JDK installation

Before installing Maven, confirm that a compatible JDK is available on the system.

Open a new terminal and run:

```sh
java -version
```

The output should be similar to:

```text
openjdk version "21.0.4" 2024-07-16 LTS
OpenJDK Runtime Environment (build 21.0.4+7-LTS)
OpenJDK 64-Bit Server VM (build 21.0.4+7-LTS, mixed mode, sharing)
```

If the command is not found, install a JDK and verify the installation again.

### Configure `JAVA_HOME`

Maven uses the `JAVA_HOME` environment variable to locate the JDK at runtime.
Maven may fail to start when `JAVA_HOME` is missing or points to an invalid directory, even when the `java` executable is on the `PATH`.
Configure `JAVA_HOME` so that it is available in every shell session that runs Maven.

=== "macOS / Linux (bash, zsh)"

    Add the following lines to the shell profile (`~/.zshrc`, `~/.bashrc`, or `~/.profile`), and replace the path with the actual JDK location:

    ```sh
    export JAVA_HOME=/path/to/your/jdk
    export PATH="$JAVA_HOME/bin:$PATH"
    ```

    On macOS, the helper `/usr/libexec/java_home` returns the currently installed JDK location:

    ```sh
    export JAVA_HOME=$(/usr/libexec/java_home)
    ```

    Reload the shell (`source ~/.zshrc`) or open a new terminal so the change takes effect.

=== "Windows (PowerShell)"

    Set the variable for the current user account:

    ```powershell
    [Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk-21", "User")
    ```

    Alternatively, configure the variable through the graphical interface.
    Navigate to `Settings` → `System` → `About` → `Advanced system settings` → `Environment Variables`, or search for `Environment Variables` using the Windows search bar.

    Open a new PowerShell or Command Prompt window so the change takes effect.

## Install Maven

There are two common ways to install Maven:

- **Through a package manager.** This is the quickest path on most systems, and the package manager handles upgrades.
- **From the official binary archive.** This gives full control over the installed version and its location on disk.

Both approaches result in a working `mvn` command.
Most package managers configure the `PATH` automatically; the binary-archive method requires this to be done manually, as described in [Add Maven to the `PATH`](#3-add-maven-to-the-path).

### Install with a package manager

The package managers listed below are some of the most commonly used.
They are not the only options — other Java toolchain managers can install Maven as well.

=== "Cross-platform"

    [SDKMAN!](https://sdkman.io/) is available on macOS, Linux, and Windows Subsystem for Linux, and can install Maven alongside several JDK distributions:

    ```sh
    sdk install maven
    ```

    SDKMAN! adds `mvn` to the `PATH` automatically.

=== "macOS"

    With [Homebrew](https://brew.sh/):

    ```sh
    brew install maven
    ```

    With [MacPorts](https://www.macports.org/):

    ```sh
    sudo port install maven3
    ```

=== "Linux"

    The exact command depends on the distribution's package manager:

    ```sh
    # Debian / Ubuntu
    sudo apt update
    sudo apt install maven

    # Fedora / RHEL / CentOS Stream (dnf)
    sudo dnf install maven

    # Older RHEL / CentOS (yum)
    sudo yum install maven
    ```

    Distributions other than those listed (for example, Arch Linux) ship Maven through their own package managers as well.

=== "Windows"

    With [Chocolatey](https://chocolatey.org/):

    ```powershell
    choco install maven
    ```

    With [Scoop](https://scoop.sh/):

    ```powershell
    scoop install main/maven
    ```

!!! note "Package manager versions may lag behind"
    Every package manager ships Maven some time after a release is published by the Apache Maven team, because each tool depends on that release as its source.
    For tools such as Homebrew, Chocolatey, Scoop, and SDKMAN!, the delay is usually a few days.
    Linux distribution repositories often lag behind by weeks or months.
    To install a specific (especially the latest) Maven version, prefer [the binary archive](#install-from-the-binary-archive) or [SDKMAN!](https://sdkman.io/).

After the package manager finishes, continue with [Verify the installation](#verify-the-installation).

### Install from the binary archive

This method works on any system and installs the exact version published by the Apache Maven team.

The steps below use Maven `3.9.16` as an example.
Replace the version number with the version that was downloaded.

#### 1. Download the archive

Open the [Maven download page](https://maven.apache.org/download.html) and download the latest **binary** distribution.
Two formats are offered:

- `apache-maven-<version>-bin.zip` — works on every platform and is the most convenient on Windows;
- `apache-maven-<version>-bin.tar.gz` — convenient on macOS and Linux.

!!! tip "Verify the integrity of the download (optional but recommended)"
    For production setups, check the downloaded archive against the published [PGP signatures and checksums](https://www.apache.org/info/verification.html) using the public [KEYS](https://downloads.apache.org/maven/KEYS) file.
    This ensures the archive has not been tampered with during transfer.

#### 2. Extract the archive

Extract the archive into a directory of choice, for example:

- macOS / Linux: `/opt/apache-maven-3.9.16` or `~/tools/apache-maven-3.9.16`
- Windows: `C:\apache-maven-3.9.16` or `C:\Program Files\Apache\apache-maven-3.9.16`

=== "macOS / Linux"

    The example below assumes the archive `apache-maven-3.9.16-bin.tar.gz` was downloaded, and extracts it into `/opt`, which creates `/opt/apache-maven-3.9.16`:

    ```sh
    sudo tar -xzf apache-maven-3.9.16-bin.tar.gz -C /opt
    ```

=== "Windows (PowerShell)"

    The example below assumes the archive `apache-maven-3.9.16-bin.zip` was downloaded, and extracts it into `C:\`, which creates `C:\apache-maven-3.9.16`:

    ```powershell
    Expand-Archive -Path apache-maven-3.9.16-bin.zip -DestinationPath C:\
    ```

#### 3. Add Maven to the `PATH`

To make the `mvn` command available from any terminal, add the `bin` directory of the Maven installation to the `PATH` environment variable.

!!! note
    Some installation methods (SDKMAN!, Homebrew, Chocolatey, Scoop, and most Linux package managers) configure `PATH` automatically.
    This step is therefore only required when Maven was installed from the binary archive.

The examples below assume Maven `3.9.16` was extracted to the directory shown in the previous step.

=== "macOS / Linux (bash, zsh)"

    Add the following line to the shell profile (`~/.zshrc`, `~/.bashrc`, or `~/.profile`):

    ```sh
    export PATH="/opt/apache-maven-3.9.16/bin:$PATH"
    ```

    Reload the shell, for example:

    ```sh
    source ~/.zshrc
    ```

=== "Windows (PowerShell)"

    The snippet below appends Maven's `bin` directory to the user-level `Path`.
    It is safe to re-run: the directory is only added when it is not already present.

    ```powershell
    $mavenBin = "C:\apache-maven-3.9.16\bin"
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($userPath -notlike "*$mavenBin*") {
      [Environment]::SetEnvironmentVariable("Path", "$userPath;$mavenBin", "User")
    }
    ```

    Alternatively, use the graphical interface.
    Navigate to `Settings` → `System` → `About` → `Advanced system settings` → `Environment Variables` (or search for `Environment Variables` using the Windows search bar), then append `C:\apache-maven-3.9.16\bin` to the `Path` variable.

    Open a new terminal so the change takes effect.

## Verify the installation

Open a **new** terminal so the latest environment variables are picked up, and run:

```sh
mvn -v
```

The alternative `mvn --version` produces the same output.

The output reports the installed Maven version, the Maven installation directory, the JDK Maven is using, and basic operating-system information.
Example:

```text
Apache Maven 3.9.16 (2bdd9fddda4b155ebf8000e807eb73fd829a51d5)
Maven home: /opt/apache-maven-3.9.16
Java version: 21.0.4, vendor: Eclipse Adoptium, runtime: /opt/jdk-21
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "6.8.0", arch: "amd64", family: "unix"
```

If such output is shown, **Maven is correctly set up and ready to use**.

## Troubleshooting

??? failure "`mvn: command not found` (or `'mvn' is not recognized...`)"
    The `mvn` command is not on the `PATH`.
    Confirm that:

    - the `bin` directory inside the Maven installation is on `PATH`;
    - the current terminal was opened **after** the environment variables were updated.

    Inspect the current `PATH` with `echo $PATH` (macOS/Linux), `echo $env:PATH` (Windows PowerShell), or `echo %PATH%` (Windows Command Prompt).

??? failure "`JAVA_HOME is not defined correctly`"
    Maven cannot find the JDK.
    Check that:

    - `JAVA_HOME` points to a directory where a JDK is installed (not a JRE, and not the `bin/` subdirectory of a JDK);
    - that directory exists and contains `bin/java` (or `bin\java.exe` on Windows).

    Inspect the current value with `echo $JAVA_HOME` (macOS/Linux), `echo $env:JAVA_HOME` (Windows PowerShell), or `echo %JAVA_HOME%` (Windows Command Prompt).

??? failure "Wrong Java version is used"
    The output of `mvn -v` reports the JDK Maven is using.
    If it does not match the expected JDK, either `JAVA_HOME` or `PATH` points to a different JDK installation.
    Update whichever is incorrect and open a new shell.

    Each Maven version also requires a minimum JDK version, as listed in [Prerequisites: a working JDK](#prerequisites-a-working-jdk).
    For example, running Maven 4 with a JDK older than 17 will fail.

??? question "Behind a corporate proxy?"
    Maven may be unable to download dependencies on first use when running behind a corporate proxy.
    Configure a proxy in `~/.m2/settings.xml` as described in the [Guide to Configuring Maven](https://maven.apache.org/guides/mini/guide-configuring-maven.html).

## What's next?

Once Maven is installed and verified, the next step is to build a sample project.

[Continue: Basic project sample →](basic-project-sample.md)
