# Super-Mario-3D-All-Stars-Super-Deluxe
<img width="2160" height="540" alt="3D All Stars SUPER DELUXE banner" src="https://github.com/user-attachments/assets/77c1f929-bc1e-453b-a49c-995f20c250ed" />
This modification of [Super Mario 3D All-Stars Deluxe](https://gitlab.com/Minibattle/super-mario-3d-all-stars-deluxe#download-here) by Minibattle adds up to four additional games to the launcher:

- Super Mario 64 DS
- Super Mario Eclipse
- Super Mario 3D World + Bowser's Fury
- Super Mario Odyssey

The result is a complete collection of every mainline 3D Mario game, plus Sunshine's fan-made sequel.
Furthermore, Super Mario 64 DS includes an Analog Hack and is preconfigured to run at 4 times the base DS resolution.
You may choose which games to install during setup.


## Files you will need
- Super Mario 64 DS.nds
- Super Mario Eclipse.iso
- Super Mario 3D World + Bowser's Fury.nsp
- Super Mario Odyssey.nsp
- Switch emulator of your choice

You may omit any games that you do not wish to have, including the switch emulator if you don't want to install 3D World or Odyssey.
This mod supports USA Rev 0 and USA Rev 1 of Super Mario 64 DS.



## File Names and Locations
All ROMs must be named exactly as shown. 
Furthermore, if you are adding a switch emulator, ensure the .exe file is named "switchemulator.exe" and the root folder is named "Switch".
File and folder structure should look like this:

```text
Super Mario 3D All-Stars Deluxe/
├── data/
│   ├── Switch/
│   │   ├── switchemulator.exe
│   │   └── [other switch emulator files]
│   └── ROMS/
│       ├── Super Mario 64 DS.nds
│       ├── Super Mario Eclipse.iso
│       ├── Super Mario 3D World + Bowser's Fury.nsp
│       └── Super Mario Odyssey.nsp
```

## How to install games to the launcher
1) Place files in appropriate locations with exact names.
2) Run the "install.bat" file located in the same folder as the readme.txt.
3) Select the location of your Super Mario 3D All-Stars Deluxe folder.
4) Run installation process (full or custom).
5) Select your preferences when prompted.
6) Complete! Run "Super Mario 3D All-Stars DELUXE.exe" and you should see your new games on the launcher.


## Known Issues
When using certain switch emulators (Yuzu, Ryujinx, Citron), the launcher is unable to boot straight into Odyssey or 3d World. Instead, it will just open the emulator without booting a game. 
For best compatibility, use Eden, as that is the only one known to be able to boot straight into games without any additional input.


## Other tools available through this mod
- Uninstall Mod 
  - Removes all files added by the installer. 
  - (ROMs and Switch Emulator must be removed manually.)

- Configure Switch Emulator
  - Launches "switchemulator.exe" without starting a game, allowing you to configure settings and controls.

- Restore Super Mario 64 DS Save
  - Restores a previously backed-up save file to DeSmuME's Battery folder. 
  - (Backups can be created during uninstallation.)

- Change Installation Folder
  - Allows you to change the installation directory without restarting the installer.


## Compatibility
This installer is designed for Windows 10 and Windows 11.


## Credits
- Super Mario 3D All-Stars Deluxe - Minibattle
- Super Mario Eclipse icon assets - Some-Crappy-Edits of Eclipse Team
- DeSmuME with Analog Hack for SM64DS - LRFLEW
- DeSmuME originally by YopYop156

## DeSmuME Emulator
This project includes a modified build of DeSmuME, an open-source Nintendo DS emulator.

DeSmuME is licensed under the GNU General Public License (GPL). See LICENSE_desmume.txt for details.
Source code and original project can be found at:
https://github.com/LRFLEW/AM64DS_DeSmuME


## Disclaimer
This project is a fan-made modification and is not affiliated with, endorsed by, or supported by Nintendo or any of its subsidiaries.

This installer does not include any copyrighted game files or ROMs. Users are required to supply their own legally obtained game files.

By using this software, you acknowledge that you are responsible for ensuring you have the legal right to use any game files or software with this project.

The creator of this project is not responsible for any misuse of this software, data loss, or damage to your system. It is recommended to back up any important files before use.

This project is intended for personal and educational use only.
