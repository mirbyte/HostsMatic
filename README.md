# HostsMatic
*Windows-Hosts-File-Blocklist-Automater*

[![License](https://img.shields.io/github/license/mirbyte/HostsMatic?color=white&maxAge=604800)](https://raw.githubusercontent.com/mirbyte/HostsMatic/master/LICENSE)
![Size](https://img.shields.io/github/repo-size/mirbyte/HostsMatic?label=size&color=white&maxAge=86400)
![Last Commit](https://img.shields.io/github/last-commit/mirbyte/HostsMatic?color=white&label=repo+updated)

<!--[![Download Count](https://img.shields.io/github/downloads/mirbyte/HostsMatic/total?color=white&maxAge=86400)](https://github.com/mirbyte/HostsMatic/releases)-->
<!--[![Latest Release](https://img.shields.io/github/release/mirbyte/HostsMatic.svg?color=white&maxAge=86400)](https://github.com/mirbyte/HostsMatic/releases/latest)-->

## EARLY TEST RELEASE !
Usage of hosts file is an outdated method but many people still use it. DNS over HTTPS skips the use of hosts file. These three files work together to provide a complete solution for managing Windows hosts file updates with blocklists, including installation and removal.

**1. installer.bat**
   - Windows batch script that installs HostsMatic
   - Creates installation directory in Program Files
   - Copies necessary files and creates a shortcut in Startup folder
   - Creates a backup of the original hosts file
   - Runs initial setup wizard

**2. HostsMatic.exe**
   - Compiled Python script that manages host file updates
   - Includes Microsoft telemetry blocklist
   - Handles automatic updates and DNS cache flushing
   - Provides setup wizard for configuration
  
**3. uninstaller.bat**
   - Windows batch script that removes HostsMatic
   - Removes program files and startup shortcut
   - Optionally restores original hosts file from backup
   - Provides cleanup options for backup files







<br>

### Sources:
- https://github.com/StevenBlack/hosts
- https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/hosts/native.winoffice.txt
- https://github.com/pschneider1968/pihole-bl-msft-telemetry-bsi
