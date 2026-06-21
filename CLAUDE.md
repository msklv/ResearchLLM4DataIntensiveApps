# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A research project exploring how to embed LLMs/AI agents into data-intensive enterprise applications. The hard constraint driving every design decision: **data cannot leave the organization — only on-premise, open-source, locally-inferenced solutions are in scope** (see `README.md`, `UseCases.md`). When evaluating tools or models, prefer ones that run via local inference (Ollama / LM Studio / TEI) or an OpenAI-compatible on-prem endpoint.

This is primarily a **documentation + runnable-stack** repo, not an application codebase. Most content is Markdown guides (in Russian) plus self-contained Docker Compose stacks and one Jupyter notebook. There is no project-wide build, lint, or test step.

## Language rule

**Reply to the user in Russian** unless they explicitly ask otherwise. Documentation in this repo is written in Russian; match it.

## Repository structure

Each top-level directory is an independent subproject with its own `readme.md` (start there before touching it):

- `SearchPortal/` — corporate document-search portal. Open WebUI + Qdrant + Redis + Apache Tika stack. `config.json` is an exported Open WebUI settings snapshot (RAG params, embedding/reranking config).
- `AgentWithRag/` — RAG agent research. `RAG_Assistant.ipynb` (LangChain + Qdrant) backed by a TEI + Ollama + Qdrant stack (`compose.yaml`, configured via `.env`).
- `CodeAutocomplete/` — local IDE code-assist setup (Continue.dev / KiloCode + Ollama). `config.yaml` is an example Continue config.
- `n8n/` — Telegram-group automation via n8n (n8n + Postgres + Redis + Qdrant).
- `mac-agent/`, `fast-ai-dev/` — guides (personal-productivity agents; spec-driven development with coding agents). Docs only.
- `docs/` — shared theory, hardware guidance, and the MacBook LLM setup guide that the subproject readmes link to.
- `tools/` — small Ollama helper scripts.

`AGENTS.md` holds additional code-style and commit conventions.

## Running the stacks

Each subproject is brought up with Docker Compose from its own directory:

```bash
# SearchPortal — Open WebUI on :3000, Qdrant :6333, Redis Commander :8081
cd SearchPortal && docker compose up -d        # down; rm -rf ./.data to wipe all state

# AgentWithRag — profile-gated (TEI + Ollama + Qdrant); model/ports come from .env
cd AgentWithRag && docker compose --profile cpu up -d   # or --profile gpu
jupyter notebook RAG_Assistant.ipynb

# n8n — n8n on :5678
cd n8n && docker compose up -d
```

Conventions baked into the stacks, worth preserving when editing compose files:

- **`platform: linux/amd64`** is set on images without ARM builds (Tika, Redis Commander) so they run under emulation on Apple Silicon — don't drop it.
- **Apple Silicon GPU caveat:** Docker has no Metal/MPS passthrough, so containerized inference on Mac is CPU-only. For real acceleration, TEI is run **natively** via Homebrew (`text-embeddings-router`), not in Docker — see `AgentWithRag/readme.md`.
- LLM endpoints are reached from containers via `host.docker.internal:11434` (Ollama running on the host), not a containerized Ollama, in SearchPortal.
- Secrets (`OPENAI_API_KEY`, etc.) come from the environment / `.env`; the OpenAI-compatible base URL points at an on-prem/sovereign-cloud endpoint, not api.openai.com.

## Standard local ports

`3000` Open WebUI · `5678` n8n · `6333`/`6334` Qdrant HTTP/gRPC · `8081` Redis Commander · `9998` Tika · `11434` Ollama · `9090` TEI.

## Models

Model choices skew toward Russian-language support and local-inference feasibility (Qwen3 / Qwen-Coder, GLM, gemma, `bge-m3` and `Qwen3-Embedding` for embeddings). RAM/vRAM requirements for embedding models are noted in `AgentWithRag/readme.md` / `.env` — respect them when suggesting a model.
