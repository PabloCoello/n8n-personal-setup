# Quick Start Guide

Get up and running with n8n AI starter kit in 5 minutes!

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed and running
- [Docker Compose](https://docs.docker.com/compose/install/) (usually included with Docker Desktop)
- At least 4GB of free RAM
- Internet connection for downloading models

## Step 1: Clone and Setup

```bash
# Clone the repository
git clone https://github.com/PabloCoello/n8n-personal-setup.git
cd n8n-personal-setup

# Run initial setup
make setup
```

This will:
- Create a `.env` file from the template
- Create the `shared/` directory for file access

## Step 2: Secure Your Installation

Generate secure keys (recommended):

```bash
# Generate new encryption keys
make generate-keys

# Copy the output and update your .env file
```

Update your `.env` file with:
1. The generated keys from above
2. A strong PostgreSQL password
3. Any other custom settings

## Step 3: Start the Services

Choose your profile based on your hardware:

### For CPU-only systems:
```bash
make start
```

### For systems with Nvidia GPU:
```bash
make start PROFILE=gpu-nvidia
```

### For systems with AMD GPU (Linux):
```bash
make start PROFILE=gpu-amd
```

## Step 4: Access n8n

1. Wait about 30 seconds for all services to initialize
2. Open your browser and go to: **http://localhost:5678**
3. Create your n8n account (first time only)
4. You'll see the demo workflow already loaded!

## Step 5: Try the Demo Workflow

1. Open the demo workflow: http://localhost:5678/workflow/srOnR8PAY3u4RSwb
2. Click the **Chat** button at the bottom
3. Start chatting with the AI!

**Note**: The first time you run a workflow, Ollama may need a few minutes to download the Llama 3.2 model. Check the progress:

```bash
make logs-ollama
```

## Common Commands

```bash
make help          # See all available commands
make logs          # View logs from all services
make status        # Check service status
make stop          # Stop all services
make restart       # Restart services
make check-env     # Validate your configuration
```

## What's Running?

After starting, you have access to:

- **n8n**: http://localhost:5678 - Workflow automation platform
- **Qdrant**: http://localhost:6333 - Vector database
- **Ollama**: http://localhost:11434 - LLM inference
- **PostgreSQL**: Port 5432 - Database (internal only)

## Next Steps

### Explore Workflows
Visit the [n8n template gallery](https://n8n.io/workflows/) to find more AI workflows. Click "Use workflow" to import them directly.

### Use Local Files
Place files in the `shared/` directory and access them in n8n at `/data/shared/your-file.txt`. See `shared/README.md` for details.

### Learn More
- [n8n AI Documentation](https://docs.n8n.io/advanced-ai/)
- [Ollama Models](https://ollama.com/library)
- [Troubleshooting Guide](README.md#-troubleshooting)

## Stopping and Cleaning Up

### Stop services:
```bash
make stop
```

### Remove all data (warning - destructive!):
```bash
make clean
```

## Need Help?

If something isn't working:

1. Check the [Troubleshooting section](README.md#-troubleshooting) in the README
2. Run `make status` to see if all services are running
3. Run `make logs` to check for errors
4. Visit the [n8n community forum](https://community.n8n.io/)

## Security Reminder

⚠️ **Important**: This setup is for local development and learning. Before using in production:

1. Change all default passwords in `.env`
2. Generate secure encryption keys
3. Review the [SECURITY.md](SECURITY.md) file
4. Implement proper access controls and SSL/TLS

---

**Enjoy building AI workflows with n8n!** 🚀
