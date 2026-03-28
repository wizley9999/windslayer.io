# WindSlayer Language Patching Tool

A lightweight deployment tool that automatically applies English localization files to the Korean **WindSlayer** client.

This tool is designed for global players who want a faster and more convenient way to patch language files without manually navigating the client directory.

## Overview

The WindSlayer Language Patching Tool:

- Checks for the latest version before applying the patch
- Automatically detects the WindSlayer installation path using the `windslayer://` protocol
- Locates the internal `hs` directory
- Applies updated localization files in one click

### What This Tool Does

When executed, the tool will:

1. Check GitHub for the latest release version.
2. If a newer version exists, display the download URL and cancel the patch.
3. If up to date, detect the registered WindSlayer client path from the Windows registry.
4. Identify the `hs` folder inside the installation directory.
5. Copy new localization files into the client directory.

### How to Use

#### 1. Download

Download the latest release package in [here](https://github.com/wizley9999/windslayer-guide/releases).

```
https://github.com/wizley9999/windslayer-guide/releases
```

#### 2. Extract

Extract all files into the same folder.

The folder should contain:

```
## PATCHER

- run.bat
- hs\hs.ps1

## RESOURCES

- hs\UILngKo.lng
- hs\QSTLngKo.lng
- hs\NPCLngKo.lng
- hs\MapLngKo.lng
- hs\ITMLngKo.lng
- hs\windslayer.hpt
- hs\windslayer.bct
```

#### 3. Execute

Double-click:

```
run.bat
```

Windows will prompt for Administrator permission.

Approve the request.

The patching process will begin automatically.

## Update Check

Every time the patcher runs, it checks the latest release on GitHub before applying any files.

If your patcher version is outdated:

```
A newer version of the patcher is available.
  Current version : v20260301
  Latest version  : v20260329

Download the latest patcher from:
  https://github.com/wizley9999/windslayer-guide/releases/tag/v20260329

Patching has been cancelled. Please use the latest version.
```

The patch will **not** be applied until you download and run the latest version.

This ensures that you always apply the most current and accurate localization files.

If you have no internet connection, the update check is skipped and the patch proceeds normally.

## Limitations

- This tool only replaces specified localization files.
- It does not modify core executables.
- It does not bypass regional restrictions.
- It does not fully translate every part of the client. Some in-game text, system messages, or UI elements may remain in Korean depending on how the original client handles localization.

## Disclaimer

This tool is unofficial and not affiliated with Sesisoft.

Use at your own risk.

The author is not responsible for:

- Account suspensions
- Game restrictions
- Data loss
- System instability
- Any consequences resulting from file modification

Users are responsible for ensuring compliance with the game's Terms of Service.

## Screenshots

![1](2026-03-01-language-patcher/1.png)
