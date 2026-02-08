# AGENTS.md

## Project Overview

Research project for implementing LLM-based agents in data-intensive applications. Focus on on-premise open source solutions and local or on-premise infrastructure deployment of LLMs.

## Build, Run, and Test Commands

### SearchPortal (Python)

```bash
# See ./SearchPortal/readme.md for specific Python environment setup

# Docker environment likely required
docker-compose -f ./SearchPortal/docker-compose.yml up -d
```

### AgentWithRag (Python)

```bash
# Jupyter notebook
cd AgentWithRag
jupyter notebook RAG_Assistant.ipynb

# Python requirements
# See AgentWithRag/python.md for dependencies
```

### N8N

```bash
# Docker environment likely required
docker-compose -f ./n8n/docker-compose.yml up -d
```

## Code Style Guidelines

### Python

- Follow PEP 8 style guide
- Use snake_case for function and variable names
- Use PascalCase for class names
- Use underscore suffix for private members


## Configuration

**Python Settings Location**
- `./SearchPortal/config.json` contains SearchPortal configuration


## Dependencies & Environment

**Minimum Requirements**
- Python with appropriate virtual environments
- Docker for services requiring containers (Ollama, Qdrant, etc.)


## Commit Guidelines

- Use commit messages that focus on "why" rather than "what"
- When working with features, write tests first (TDD)
- Never commit sensitive data (tokens, passwords)
- Maintain the existing structure and organization patterns

## Active Projects

### Portal
Portal with base RAG implementation using Qdrant vector

### AgentWithRag
Research notebook for RAG agent implementation

### Code Autocomplete
IDE VSCode implementation of code Autocomplete with local LLM

### N8N Automation
Telegram group automation using n8n pipelines

### mac-agent
Automatization of macOS

## Rules

- Always reply to the user in Russian unless explicitly stated otherwise.
