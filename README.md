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
3. Run setup:
```cmd
   cmd /k setup.bat
```
   This will automatically install:
   - Node.js
   - Docker Desktop
   - Ollama
   - All dependencies
   - AI models: qwen2.5:7b and translategemma
4. If prompted to restart your computer, do so, then come back and run setup.bat again.
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

## Available demos
| Demo | Model | Description |
|------|-------|-------------|
| ASU Student Wellbeing | qwen2.5:7b | Mental health support companion for ASU students |
| Syllabot | qwen2.5:7b | Upload your syllabus and ask questions about your course |
| Language Translator | translategemma | Translate text across 55 languages, no internet required |

## Updating Ollama models
To pull the latest versions of all AI models:
```cmd
update-models.bat
```
This pulls `qwen2.5:7b` and `translategemma`. Run this after a fresh install or when new models are added.

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
Or to update Ollama models separately:
```cmd
update-models.bat
```

## Releasing updates (Next Lab staff only)
Frontend changes are now automated via GitHub Actions. When a change is published in Lovable:
1. The frontend is automatically built and pushed to this repo
2. The version number is automatically incremented
3. Recipients will be prompted to update on their next `start.bat` launch

For Open WebUI config changes (admin settings, models, knowledge base):
1. Double-click `export-config.bat`
2. Enter the new version number when prompted

This will automatically:
- Export Open WebUI config
- Bump version number
- Push everything to GitHub and tag the release

Wait 2-3 minutes for GitHub cache to clear before testing.

## Shutting down
Double-click `stop.bat`

## Version history
| Version | Notes |
|---------|-------|
| v1.0.9  | Automated Lovable frontend sync via GitHub Actions — frontend updates and version bumps happen automatically on every Lovable publish |
| v1.0.8  | Language Translator demo, translategemma model |
| v1.0.7  | update-models.bat, translategemma added to setup |
| v1.0.6  | One-click export, Syllabot demo added |
| v1.0.5  | Improved setup.bat - Docker autostart, Ollama detection |
| v1.0.4  | Fix setup for different install locations |
| v1.0.3  | Version management, one-click export-config |
| v1.0.2  | Version checking, auto-update on startup |
| v1.0.1  | Admin portal, auto-login proxy |
| v1.0.0  | Initial release |
