# OpenRGB Ubuntu Suspend Automation

A simple systemd hook script for Ubuntu/Debian systems that automatically turns off RGB lighting via OpenRGB when the PC suspends, and restores your default RGB profile upon waking up or booting.

## Features
* **Auto-Off on Suspend:** Transitions all RGB devices to an `off` profile before the system sleeps.
* **Auto-On on Wake:** Restores your `default` profile when the system wakes up, with a slight delay to allow USB controllers to initialize.
* **Cold Boot Support:** Instructions to load your profile automatically on a fresh system boot.

---

## Prerequisites

1. **OpenRGB** must be installed and accessible via the terminal.
2. Open the OpenRGB GUI and create/save two profiles:
   * `off` (All lights set to black/off)
   * `default` (Your preferred everyday lighting setup)

---

## Installation & Setup

### 1. Create the Systemd Sleep Script
Systemd allows us to execute scripts during power state changes. Create a new script file in the system sleep directory:

```bash
sudo nano /lib/systemd/system-sleep/openrgb-toggle
```

### 2. Add the script content
Paste the following script into the file. Make sure to replace `yourusername` with your actual Ubuntu username (run whoami if you are unsure).
```bash
#!/bin/sh

# Replace 'yourusername' with your actual Ubuntu username
USER_NAME="yourusername"
USER_HOME="/home/$USER_NAME"

case "$1" in
    pre)
        # Actions to run BEFORE the PC suspends
        sudo -u "$USER_NAME" DISPLAY=:0 XAUTHORITY="$USER_HOME/.Xauthority" openrgb --profile off
        ;;
    post)
        # Actions to run AFTER the PC wakes up
        sleep 2 # Brief pause to let USB controllers initialize
        sudo -u "$USER_NAME" DISPLAY=:0 XAUTHORITY="$USER_HOME/.Xauthority" openrgb --profile default
        ;;
esac
```

### 3. Make The Script Executable
Give the system permission to execute the script:
```bash
sudo chmod +x /lib/systemd/system-sleep/openrgb-toggle
```
<img width="1440" height="508" alt="image" src="https://github.com/user-attachments/assets/1514e6d0-d4d3-42af-80e8-7012fa591a33" />

## Optional: Load Profile on Cold Boot
The script above handles suspend/resume cycles. To ensure your profile also loads when you completely turn on or restart your PC:

    1. Open the Startup Applications utility from your Ubuntu Dash.

    2. Click Add.

    3. Enter the following details:

        Name: OpenRGB Default Profile

        Command: openrgb --profile default

        Comment: Loads RGB profile on system boot.

    4. Click Save.

<img width="1522" height="1160" alt="image" src="https://github.com/user-attachments/assets/1751c222-cb45-4323-9788-6cf046dabb77" />
