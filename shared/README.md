# Shared Directory

This directory is mounted to the n8n container at `/data/shared` and allows n8n workflows to access files on your local filesystem.

## Usage

1. Place files you want to access from n8n workflows in this directory
2. In n8n, reference files using the path `/data/shared/your-file.txt`

## Example Nodes

This shared directory is useful with the following n8n nodes:

- **Read/Write Files from Disk**: Read and write files to this location
- **Local File Trigger**: Monitor this directory for new or changed files
- **Execute Command**: Access files in scripts

## Security Note

⚠️ **Important**: This directory is directly accessible to n8n. Be careful about:
- Storing sensitive files here
- Executing untrusted files
- Granting write permissions to untrusted workflows

Only place files here that you want n8n to access.

## Example Files

You can add various file types for your workflows:
- Text files (`.txt`, `.csv`, `.json`)
- PDFs for document processing
- Images for AI vision tasks
- Data files for analysis

## Troubleshooting

If n8n can't access files in this directory:

1. Check that the file exists in `./shared/` on your host
2. Verify the path is `/data/shared/filename` in n8n
3. Check file permissions (should be readable by the container)
4. Restart n8n if you just created the shared directory: `docker compose restart n8n`
