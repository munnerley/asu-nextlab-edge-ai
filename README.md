# ASU Next Lab Edge AI Demo

A self-contained local AI demo kit running entirely offline.

## What's included
- Lovable frontend (pre-built, no compile needed)
- Open WebUI (served via Docker) with pre-configured demo accounts
- Ollama (local AI models)
- Auto-login proxy for seamless demo experience

## Prerequisites — install these once

1. [Git](https://git-scm.com/download/win)
2. [Node.js LTS](https://nodejs.org)
3. [Docker Desktop](https://www.docker.com/products/docker-desktop/)
4. [Ollama](https://ollama.com/download)

## First-time setup

Open a terminal and run:
```bash
git clone https://github.com/munnerley/asu-nextlab-edge-ai
cd asu-nextlab-edge-ai
npm install -g serve
npm install
```

Pull an AI model (one time):
```bash
ollama pull qwen2.5:7b
```

Start everything:
```bash
cmd /c start.bat
```

## Every subsequent use
```bash
cmd /c start.bat
```

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
```bash
cmd /c update.bat
```

Then restart with `cmd /c start.bat`.

## Pushing config updates (Next Lab staff only)

After making changes in Admin WebUI, run:
```bash
export-config.bat
```

This exports the Open WebUI config and pushes it to GitHub.
Recipients run `update.bat` to get the latest.

## Shutting down
```bash
cmd /c stop.bat
```