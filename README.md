# Zu Techy's Windows Utility

A curated compilation of Windows system tasks streamline **installs**, debloat with **tweaks**, troubleshoot with **config**, and configure **Windows updates**. Run it fresh on every new Windows install.

![Title Screen](/docs/assets/images/Title-Screen.png)

---

## Quick Start

> **WinUtil must be run as Administrator** Because it performs system-wide changes.

Open PowerShell or Terminal as admin, then run:

**Stable Branch (recommended)**
```ps1
irm https://raw.githubusercontent.com/ZuanCrisp/Windows-Utility/master/winutil.ps1 | iex
```

### How to open an admin terminal

- **Start menu:** Right-click Start → *Windows PowerShell (Admin)* or *Terminal (Admin)*
- **Search:** Press the `Windows key`, and type `PowerShell` or `Terminal`, then `Ctrl + Shift + Enter`

---

## Automation / Presets

Apply a predefined configuration without manual selection:

```powershell
& ([ScriptBlock]::Create((irm https://raw.githubusercontent.com/ZuanCrisp/Windows-Utility/master/winutil.ps1))) -Preset Standard
```

| Preset | Description |
|--------|-------------|
| `Standard` | Balanced defaults for most users |
| `Minimal` | Minimal changes to suit every user |
| `Advanced` | Deep tweaks for power users |

To view exactly what each preset does, see:
https://github.com/ZuanCrisp/Windows-Utility/blob/master/config/preset.json

---

## Build & Develop

See https://github.com/ZuanCrisp/Windows-Utility/blob/master/.github/CONTRIBUTING.md

---

## Resources

- [Official Documentation](https://github.com/ZuanCrisp/Windows-Utility)
- [Known Issues](https://github.com/ZuanCrisp/Windows-Utility/issues)
- [Report an Issue](https://github.com/ZuanCrisp/Windows-Utility/issues)

---

## Support

- Leave a ⭐ to show support!
