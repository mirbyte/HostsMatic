# HostsMatic
*Windows-Hosts-File-Blocklist-Automater*
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
