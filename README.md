# ASU Next Lab Edge AI Demo

A self-contained local AI demo kit running entirely offline.

## What's included
- Lovable frontend (pre-built, no compile needed)
- Open WebUI (served via Docker) with pre-configured demo accounts
- Ollama (local AI models)

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
```

Pull an AI model (one time):
```bash
ollama pull llama3.2
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

| Service    | URL                   | Login                        |
|------------|-----------------------|------------------------------|
| Frontend   | http://localhost:8888 | No login required            |
| Open WebUI | http://localhost:3000 | demouser / nextlab2026       |

## Getting updates
```bash
cmd /c update.bat
```

Then restart with `cmd /c start.bat`.

## Admin access

Open WebUI admin login is restricted to Next Lab staff.
Contact dan@munnerley.com for admin credentials.