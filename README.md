# ASU Next Lab Edge AI Demo

A self-contained local AI demo kit running entirely offline.

## What's included
- Lovable frontend (pre-built, no compile needed)
- Open WebUI (served via Docker) with pre-configured demo accounts
- Ollama (local AI models)
- Auto-login proxy for seamless demo experience
- Version checking and auto-update on startup

## First-time setup

1. Install Git from https://git-scm.com/download/win

2. Open a terminal and clone the repo:
```bash
   git clone https://github.com/munnerley/asu-nextlab-edge-ai
   cd asu-nextlab-edge-ai
```

3. Double-click `setup.bat` — this will automatically install:
   - Node.js
   - Docker Desktop
   - Ollama
   - All dependencies
   - The AI model (qwen2.5:7b)

4. If prompted to restart your computer, do so, then come back and continue.

5. Double-click `start.bat`

## Every subsequent use

Double-click `start.bat`

On startup it will automatically check for updates and prompt you if a new version is available.

## Services

| Service       | URL                    | Access                          |
|---------------|------------------------|---------------------------------|
| Frontend      | http://localhost:8888  | No login required               |
| Demo WebUI    | http://localhost:3000  | Auto-login as demouser          |
| Admin WebUI   | http://localhost:3001  | Admin login required            |

## Admin access

Admin login is restricted to Next Lab staff.
Contact dan@munnerley.com for admin credentials.

Use the Admin WebUI at http://localhost:3001 to:
- Add or update demo conversations
- Load knowledge base documents
- Change model settings
- Manage users

Any changes made in Admin WebUI are instantly reflected in the Demo WebUI.

## Getting updates

Double-click `start.bat` — it checks for updates automatically on every launch.

Or manually pull latest:
```bash
git pull
```

## Releasing updates (Next Lab staff only)

After making changes in Admin WebUI or the frontend:

1. Double-click `export-config.bat`
2. Enter the new version number when prompted
3. Wait 2-3 minutes for GitHub cache to clear before testing

Recipients will be prompted to update on their next `start.bat` launch.

## Shutting down

Double-click `stop.bat`

| Version | Notes |
|---------|-------|
| v1.0.4  | Improved setup - Docker autostart, Ollama path detection |
| v1.0.3  | Version management, export-config with version bump |
| v1.0.2  | Version checking, auto-update on startup |
| v1.0.1  | Admin portal, auto-login proxy |
| v1.0.0  | Initial release |