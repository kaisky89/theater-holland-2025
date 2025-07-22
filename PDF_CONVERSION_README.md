# PDF Conversion Feature

This document describes the PDF conversion feature that has been added to the pre-commit hook system.

## Overview

The pre-commit hook now performs a two-step conversion process:
1. **Markdown → Fountain**: Converts `.md` theater scripts to `.fountain` format
2. **Fountain → PDF**: Converts the generated `.fountain` files to `.pdf` format using `screenplain`

## Requirements

### screenplain
The PDF conversion requires the `screenplain` package to be installed:

```bash
pip install screenplain
```

**Note**: The setup script will check for `screenplain` availability and warn you if it's missing.

## Directory Structure

The conversion process creates the following directory structure:

```
Szenen/
├── your-script.md           # Source Markdown files
├── fountain/
│   └── your-script.fountain # Generated Fountain files
└── pdf/
    └── your-script.pdf      # Generated PDF files
```

## How It Works

When you commit changes to `.md` files in the `Szenen/` directory:

1. **Pre-commit hook triggers** automatically before the commit
2. **MD → Fountain conversion** runs using `md_to_fountain.py`
3. **Fountain → PDF conversion** runs using `screenplain --format pdf`
4. **All generated files are staged** automatically for the commit

## Example Usage

The hook uses screenplain with this command format:
```bash
screenplain --format pdf "./Szenen/fountain/01 BA 01 - Gott ist staerker als der Zufall.fountain" "./Szenen/pdf/01 BA 01 - Gott ist staerker als der Zufall.pdf"
```

## File Handling

- **Source files**: Only `.md` files in `Szenen/` directory are processed
- **Excluded files**: `.meta.md` files are skipped
- **Output naming**: Generated files use the same base name as the source file
- **Automatic staging**: Both `.fountain` and `.pdf` files are automatically staged for commit

## Error Handling

The hook will:
- ✅ Continue processing other files if one conversion fails
- ❌ Exit with error code if any conversion fails
- 📊 Provide detailed summary of successes and failures
- 🔍 Show specific error messages for debugging

## Troubleshooting

### screenplain not found
```
❌ Error: screenplain is not installed or not in PATH
Please install screenplain: pip install screenplain
```

**Solution**: Install screenplain using `pip install screenplain`

### PDF conversion fails
If Fountain → PDF conversion fails but MD → Fountain succeeds:
1. Check that the `.fountain` file is valid
2. Verify screenplain can process the file manually
3. Check for special characters or formatting issues

### Manual PDF conversion
You can manually convert any fountain file to PDF:
```bash
screenplain --format pdf "path/to/file.fountain" "path/to/output.pdf"
```

## Benefits

- **Automatic workflow**: No manual PDF generation needed
- **Consistent formatting**: All PDFs use screenplain's professional formatting
- **Version control**: PDFs are automatically committed with source changes
- **Complete pipeline**: Single commit updates MD, Fountain, and PDF versions

## Customization

To modify PDF output settings, you can:
1. Edit the screenplain command in `pre-commit-hook.sh`
2. Add additional screenplain options (see `screenplain --help`)
3. Modify the output directory structure if needed

## Status Messages

The hook provides clear status messages:
- 🔄 "Converting Fountain to PDF: filename.fountain"
- ✅ "Successfully converted to: Szenen/pdf/filename.pdf" 
- ❌ "Failed to convert Fountain to PDF: filename.fountain"
- 📊 Summary with conversion counts and error counts

## Integration with Existing Workflow

This feature seamlessly extends the existing workflow:
- No changes needed to existing `.md` files
- Fountain conversion continues to work as before
- PDF generation is an additional step that doesn't interfere with existing processes
- All files (.md, .fountain, .pdf) remain in sync automatically