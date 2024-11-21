# PowerShell Presentation: Basics, Comparisons, and Advanced Scripts

## Introduction 

### What is PowerShell?

- **PowerShell** is a command-line interface and scripting language developed by Microsoft.
- **Unlike Linux shells**, which are text-based, PowerShell operates with **objects**, making it easier to process complex data.
- **Cross-platform**: Available on Windows, Linux, and macOS through PowerShell Core.

# Shell Linux vs PowerShell Comparison

| **Action**              | **Linux Shell**          | **PowerShell**                                | **PowerShell Explanation**                                                        |
|--------------------------|--------------------------|-----------------------------------------------|-----------------------------------------------------------------------------------|
| Display a message       | `echo "Hello"`           | `Write-Host "Hello"`                          | `Write-Host` displays text in color in the console.                               |
| Change directory        | `cd /path/to/directory`  | `Set-Location -Path "C:\Path\To\Folder"`      | `Set-Location` (alias: `cd`) changes the current working directory.               |
| List files              | `ls -l`                 | `Get-ChildItem`                               | Lists files and directories in the current directory.                             |
| Create a file           | `touch file.txt`        | `New-Item -Path "file.txt" -ItemType File`    | `New-Item` creates files or directories.                                          |
| Delete a file           | `rm file.txt`           | `Remove-Item -Path "file.txt"`                | Deletes a specified file or directory.                                            |
| Install a package       | `apt install package`   | `Install-Package -Name package`               | Installs a package via a manager like Chocolatey.                                 |
| Search within a file    | `grep "text" file.txt`  | `Select-String -Pattern "text" -Path file.txt`| Searches for specific text in a file.                                             |
| Download a file         | `wget URL`              | `Invoke-WebRequest -Uri URL -OutFile file`    | Downloads a file from a URL.                                                      |



# Detailed PowerShell Commands

1. `Write-Host`
- Displays text in the console.
- **Options**:
  - `-ForegroundColor`: Sets the text color.
  - `-BackgroundColor`: Sets the background color.
- **Example**:
  ```powershell
  Write-Host "This is a test" -ForegroundColor Green

2. `Set-Location` :

- Change the repertory.
  - Alias : cd.
- **Example** :
 ```powershell
Set-Location -Path "C:\Windows"`
```
3. `Get-ChildItem`
- Lists files and directories.
- **Options**:
  - `-Recurse`: Recursively lists files in subdirectories.
  - `-Filter`: Filters items by name or extension.
- **Example**:
  ```powershell
  Get-ChildItem -Recurse -Filter *.txt

4. `New-Item`
- Creates a new file or directory.
- **Options**:
  - `-Path`: Full path to the item.
  - `-ItemType`: Specifies `File` or `Directory`.
- **Example**:
  ```powershell
  New-Item -Path "new_file.txt" -ItemType File

5. `Remove-Item`
- Deletes a file or directory.
- **Example**:
  ```powershell
  Remove-Item -Path "file.txt"

6. `Invoke-WebRequest`
- Downloads content from a URL.
- **Options**:
  - `-Uri`: URL of the file.
  - `-OutFile`: Path to save the file.
- **Example**:
  ```powershell
  Invoke-WebRequest -Uri "https://example.com/file.txt" -OutFile "file.txt"


# Another Comparison: Shell vs PowerShell

| **Action**              | **Linux Shell**                   | **PowerShell**                                         | **Explanation**                                                                          |
|--------------------------|------------------------------------|--------------------------------------------------------|------------------------------------------------------------------------------------------|
| Create a directory       | `mkdir folder`                   | `New-Item -ItemType Directory -Path folder`            | PowerShell uses `New-Item` to create any type of item.                                   |
| Display file content     | `cat file.txt`                   | `Get-Content -Path file.txt`                          | `Get-Content` reads a file line by line.                                                |
| Copy a file              | `cp source.txt destination.txt`  | `Copy-Item -Path source.txt -Destination destination.txt` | `Copy-Item` handles file copies.                                                        |
| Move a file              | `mv file.txt folder/`            | `Move-Item -Path file.txt -Destination folder`         | `Move-Item` moves or renames files.                                                     |


# Required Packages and Prerequisites

To ensure everything works properly, follow these steps:

## 1. Enable PowerShell Script Execution
By default, PowerShell blocks script execution for security reasons.

- **Check the current policy**:
  ```powershell
  Get-ExecutionPolicy

- **Enable Script Execution**:
To enable script execution, use the following command:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

**Explanations**:

- **RemoteSigned**: Allows the execution of local unsigned scripts, but requires a signature for remote scripts.
- **Scope CurrentUser**: Applies the change only to the current user.

## 2. Install Chocolatey to Simplify Installations

### Installation Command:
Run PowerShell as Administrator and execute the following:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

## Example of Installing a Package via Chocolatey:

```powershell
choco install 7zip -y
```
This command installs the 7zip package and automatically confirms the installation with the -y flag.

`choco uninstall 7zip -y` To desinstall

`choco list` To see wich Package is installed

###  **Add a program to System PATH**

1. Open the system environment variables settings:
   - Press `Win + R`, type `sysdm.cpl`, and press **Enter**.

2. Navigate to the **Advanced** tab and click **Environment Variables**.

3. Under **System Variables**, locate the `Path` variable and click **Edit**.

4. Add the following path to the list:
`C:\Program Files\7-Zip`


5. Save your changes and close the dialog boxes.

6. Restart your PowerShell session or terminal for the PATH change to take effect.

### **Verify and Use**
Now, you can simply run the following command from any directory to use `7-Zip`:
```powershell
7z.exe a archive.7z sfsf.txt
```

# PowerShell Basics

## Basic Commands

| **Command**        | **Purpose**                                  | **Example**                                  |
|--------------------|----------------------------------------------|----------------------------------------------|
| `Get-Help`         | Displays help about a command or topic.      | `Get-Help Get-Process`                       |
| `Get-Process`      | Shows processes running on the system.       | `Get-Process`                                |
| `Write-Output`     | Prints output to the console.                | `Write-Output "Hello, PowerShell!"`          |
| `Get-ChildItem`    | Lists items in a directory (like `ls`).      | `Get-ChildItem -Path C:\Windows`             |
| `Test-Path`        | Checks if a file or folder exists.           | `Test-Path C:\Temp`                          |
| `New-Item`         | Creates a new file or folder.                | `New-Item -ItemType Directory -Path C:\NewFolder` |
| `Set-Location`     | Changes the current directory (like `cd`).   | `Set-Location -Path C:\Users`                |


## Make Scripts Interactive
Use Read-Host for user input:

```powershell
$name = Read-Host "Enter your name"
Write-Output "Hello, $name!"
```

# Working on Windows AND linux/MacOS 

**Check on internet how to install PowerShellCore on Linux or MAC/OS**

https://github.com/PowerShell/PowerShell#get-powershell


If you don't use windows object command, you can use these script on each platform.

## Exemple : 

```powershell
# Define website and alert message
$Website = "https://facebook.com"

# Check website availability
try {
    Invoke-WebRequest -Uri $Website -TimeoutSec 5
    Write-Host "Website is up."
} catch {
    Write-Host "Website is down."
}
```
To launch it on linux : 

`pwsh script.ps1`


To launch it from CMD :

`powershell -ExecutionPolicy Bypass -File "PATH/TO/THE/FILE"`

# Different PowerShell Script that I made :

1. [BackUp](./BackUp) - Backup files and directories.
2. [Block Malicious IP](./Block%20Malicious%20IP) - Script to block malicious IP addresses.
3. [Bulk File Renaming](./Bulk%20File%20Renaming) - Bulk rename files in a directory.
4. [Encrypt and Decrypt files](./Encrypt%20and%20Decrypt%20files) - Encrypt and decrypt files for secure storage.
5. [Find and Kill](./Find%20and%20Kill) - Find and terminate a process by name or PID.
6. [Installation](./Installation) - Installation scripts for setting up PowerShell environments or dependencies.
7. [Interactive and Directly](./Interactive%20and%20directly) - Scripts for interactive PowerShell commands.
8. [Monitor website availability](./Monitor%20website%20availability) - Monitor the availability of a website or server.
9. [Network Connectivity Tester](./Network%20Connectivity%20Tester) - Test network connectivity and diagnose network issues.
10. [PowerShell GUI for File Operations](./PowerShell%20GUI%20for%20File%20Operations) - PowerShell-based graphical user interface for file operations.
11. [Scheduled Task Automation](./Scheduled%20Task%20Automation) - Automate tasks using PowerShell scheduled tasks.
12. [Script calling another one](./Script%20calling%20another%20one) - Example of one PowerShell script calling another.
13. [System Health Dashboard](./System%20Health%20Dashboard) - Dashboard to monitor system health and performance.
14. [System Resource Graph](./System%20Resource%20Graph) - Graphical representation of system resources usage.
15. [Windows Service Monitor](./Windows%20Service%20Monitor) - Monitor and manage Windows services.
16. [Windows and Linux](./Windows%20and%20linux) - Scripts for cross-platform (Windows and Linux) tasks.

## Usage

Each folder contains a set of scripts with detailed instructions in the respective subdirectory. Please refer to the individual script documentation for more information on how to use them.














