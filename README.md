# Security Testing Demo Kit (Internal/Restricted)

This repository is a security training and diagnostic demo kit designed to simulate a cyberattack kill chain.

## Warning
This tool is for educational and testing purposes only. Do not execute this in unauthorized environments. The user assumes all responsibility for any damage caused by its use.

## Components
- `index.html`: A fake password generation site used to lure users, including a fake system update notification.
- `Chrome_Installer.bat`: A fake installer designed to trigger PowerShell execution.
- `demo_payload.ps1`: An attack script simulating reconnaissance, persistence, and credential access.

## Setup
1. Clone this repository into a secure, controlled testing environment.
2. Open `index.html` in a browser to initiate the demo.
3. Click the "Update" button when it appears after 30 seconds.
4. Execute `Chrome_Installer.bat` (consider renaming the icon to mimic Google Chrome for realism).

## EDR/SOC Detection Points
Monitor logs (e.g., Sysmon) for the following indicators:
- **Process Creation**: `powershell.exe` launched from `cmd.exe` in hidden window mode.
- **Network**: External connection attempts to `raw.githubusercontent.com`.
- **File Discovery**: `Get-ChildItem` execution targeting sensitive file extensions in `C:\Users\Public`.
- **Persistence**: Registry write operations to `HKCU:\Software\Microsoft\Windows\CurrentVersion\Run`.
- **Credential Access**: Handle requests targeting the `lsass` process.

## Operational Security
This repository is restricted to authorized personnel. Ensure strict management of repository access and collaborator permissions.
