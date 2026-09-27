---
title: Automation
weight: 7
prev: /userguide/updates/
next: /userguide/win11creator/
---

Use Automation to run WinUtil from an exported configuration file.

Import accepts both current arrays of selection keys and legacy exports containing `Install` and `WPFInstall` properties. Legacy imports restore supported selections and report retired keys in the log and, when a window is open, a warning dialog. An invalid current config or a legacy config with no supported keys leaves the existing selections intact.

Hover over an app, tweak, or feature checkbox to find its preset JSON key. Imported selections also appear when you open a tab that has not yet been initialized.

WinUtil supports predefined presets that apply common configurations automatically:

- `Standard`
- `Minimal`
- `Advanced`

Example:

```powershell
& ([ScriptBlock]::Create((irm "https://raw.githubusercontent.com/ZuanCrisp/Windows-Utility/master/winutil.ps1"))) -Preset Standard
```

To view exactly what each preset does, see:
https://github.com/ZuanCrisp/Windows-Utility/blob/master/config/preset.json

To create your own config file:

1. Open WinUtil.
2. Click the gear icon in the top-right corner.
3. Choose **Export**.
4. Save the exported JSON file.

Once you have exported a config, launch WinUtil with it using this command:
```powershell
& ([ScriptBlock]::Create((irm "https://raw.githubusercontent.com/ZuanCrisp/Windows-Utility/master/winutil.ps1"))) -Config "C:\Path\To\Config.json"
```

This is useful for:

- Applying the same WinUtil configuration across multiple Windows 11 PCs
- Reusing a known-good baseline after reinstalling Windows
- Standardizing deployments for labs, workstations, or personal setups

> [!NOTE]
> Run the command in an elevated PowerShell session so WinUtil can apply system-level changes.
