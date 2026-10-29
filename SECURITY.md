# Security

## What this project does and doesn't do

| | |
|---|---|
| 🌐 Network access | **None.** The page's Content-Security-Policy blocks every network request. |
| 🍪 Cookies / localStorage | **Not used.** |
| 📊 Analytics / tracking | **None.** |
| 📦 External libraries | **None.** All code lives in `gargantua.html`, unminified. |
| 🗑️ Disk changes | Only `launch.ps1` deletes and recreates `%LOCALAPPDATA%\gargantua-profile` (a throwaway browser profile). Nothing else is touched. |

## Reporting a vulnerability

If you find a security issue, please **don't open a public issue**. Use GitHub's
private **Security → Report a vulnerability** feature on this repository instead.
