\# ASU Next Lab Edge AI Demo



A self-contained local AI demo kit running entirely offline.



\## What's included

\- Lovable frontend (pre-built, no compile needed)

\- Open WebUI (served via Docker)

\- Ollama (local AI models)



\## Prerequisites — install these once



1\. \[Git](https://git-scm.com/download/win)

2\. \[Node.js LTS](https://nodejs.org)

3\. \[Docker Desktop](https://www.docker.com/products/docker-desktop/)

4\. \[Ollama](https://ollama.com/download)



\## First-time setup



Open a terminal and run:

```bash

git clone https://github.com/munnerley/asu-nextlab-edge-ai

cd asu-nextlab-edge-ai

npm install -g serve

```



Then pull an AI model (one time):

```bash

ollama pull llama3.2

```



Then double-click `start.bat`.



\## Every subsequent use



Double-click `start.bat` — that's it.



\## Services



| Service   | URL                   |

|-----------|-----------------------|

| Frontend  | http://localhost:8080 |

| Open WebUI| http://localhost:3000 |



\## Getting updates



Double-click `update.bat`, then `start.bat`.

