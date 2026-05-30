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
