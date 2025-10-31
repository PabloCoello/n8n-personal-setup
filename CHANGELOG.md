# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive `.gitignore` file to exclude Docker volumes, logs, and sensitive files
- `SECURITY.md` with security best practices and guidelines
- `CODE_OF_CONDUCT.md` for community guidelines (Contributor Covenant 2.0)
- `Makefile` with 15+ commands for common operations:
  - Setup, start/stop, logs, status checking
  - Backup and restore functionality
  - Environment validation
  - Secure key generation
- Health checks for all Docker services (n8n, PostgreSQL, Qdrant, Ollama)
- Troubleshooting section in README with 8 common issues and solutions
- GitHub issue templates (bug reports, feature requests)
- GitHub pull request template with checklists
- `shared/README.md` with documentation on local file access
- Enhanced `.env.example` with detailed comments and security warnings
- CHANGELOG.md to track project changes

### Changed
- Improved README with Makefile usage instructions
- Enhanced `.env.example` with comprehensive comments and optional configuration examples
- Updated `.gitignore` to preserve documentation while excluding data files

### Security
- Added warnings about default credentials in `.env.example`
- Documented secure key generation process
- Included security best practices in dedicated SECURITY.md file

## Notes

This is a personal fork of the n8n self-hosted AI starter kit with additional improvements for:
- Enhanced security awareness
- Better developer experience
- Comprehensive documentation
- Simplified operations through automation
