# Security Policy

## Overview

This n8n personal setup is designed for local development and experimentation. While it provides a good starting point, please follow these security best practices when deploying or using this setup.

## Security Best Practices

### 1. Protect Your Credentials

- **Never commit `.env` files** to version control
- Always use `.env.example` as a template and create your own `.env` file
- Change all default passwords and secrets in your `.env` file
- Use strong, unique passwords for:
  - `POSTGRES_PASSWORD`
  - `N8N_ENCRYPTION_KEY`
  - `N8N_USER_MANAGEMENT_JWT_SECRET`

### 2. Generate Secure Keys

Generate strong encryption keys using:

```bash
# For N8N_ENCRYPTION_KEY
openssl rand -hex 32

# For N8N_USER_MANAGEMENT_JWT_SECRET
openssl rand -hex 32
```

### 3. Network Security

- **Do not expose ports publicly** without proper authentication
- The default setup exposes:
  - n8n on port `5678`
  - Qdrant on port `6333`
  - Ollama on port `11434`
- Use a reverse proxy (nginx, traefik) with SSL/TLS for production use
- Consider using Docker networks to isolate services

### 4. Data Protection

- The `shared/` directory is mounted to n8n and can access your filesystem
- Be careful what files you place in this directory
- Regularly backup your data volumes
- Sensitive data in workflows should be stored as credentials, not hardcoded

### 5. Updates and Maintenance

- Regularly update Docker images:
  ```bash
  docker compose pull
  docker compose up -d
  ```
- Monitor security advisories for:
  - n8n: https://github.com/n8n-io/n8n/security
  - PostgreSQL
  - Other components

### 6. Production Considerations

This setup is **NOT production-ready** by default. For production:

- Implement proper user authentication
- Use SSL/TLS certificates
- Set up proper backup and disaster recovery
- Implement monitoring and logging
- Use secrets management (Docker secrets, Vault, etc.)
- Harden PostgreSQL configuration
- Review and restrict file system access

## Reporting Security Issues

If you discover a security vulnerability in this setup, please:

1. **Do NOT** open a public issue
2. Contact the repository maintainer privately
3. Include detailed information about the vulnerability
4. Allow time for the issue to be addressed before public disclosure

For n8n-specific security issues, please follow the [n8n security policy](https://github.com/n8n-io/n8n/security/policy).

## Disclaimer

This setup is provided as-is for educational and development purposes. Users are responsible for securing their own deployments and data.
