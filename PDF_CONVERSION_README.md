# PDF Conversion Feature

This document describes the updated PDF conversion feature for the pre-commit hook system.

## Overview

The pre-commit hook now performs a **direct Markdown → PDF** conversion using [`mdpdf`](https://github.com/BlueHatbRit/mdpdf).  
There is **no intermediate Fountain step**—your Markdown theater scripts are converted straight to PDF.

## Requirements

### mdpdf

The PDF conversion requires the `mdpdf` package to be installed globally:

```bash
npm install -g mdpdf
```

**Note:** The setup script and pre-commit hook will check for `mdpdf` and warn you if it's missing.

## Directory Structure

The conversion process creates the following directory structure:

```
Szenen/
├── your-script.md           # Source Markdown files
└── pdf/
    └── your-script.pdf      # Generated PDF files
```

## How It Works

When you commit changes to `.md` files in the `Szenen/` directory:

1. **Pre-commit hook triggers** automatically before the commit
2. **Markdown → PDF conversion** runs using `mdpdf`
3. **All generated PDF files are staged** automatically for the commit

## Example Usage

The hook uses mdpdf with this command format:
```bash
mdpdf "./Szenen/03 GoDi 01 - Jesus ist staerker als Krankheit.md" -o "./Szenen/pdf/03 GoDi 01 - Jesus ist staerker als Krankheit.pdf"
```

## File Handling

- **Source files:** Only `.md` files in the `Szenen/` directory are processed
- **Excluded files:** `.meta.md` files are skipped
- **Output naming:** Generated files use the same base name as the source file
- **Automatic staging:** PDF files are automatically staged for commit

## Error Handling

The hook will:
- ✅ Continue processing other files if one conversion fails
- ❌ Exit with error code if any conversion fails
- 📊 Provide detailed summary of successes and failures
- 🔍 Show specific error messages for debugging

## Troubleshooting

### mdpdf not found
```
❌ Error: mdpdf is not installed or not in PATH
Please install mdpdf: npm install -g mdpdf
```

**Solution:** Install mdpdf using `npm install -g mdpdf`

### PDF conversion fails
If Markdown → PDF conversion fails:
1. Check that the `.md` file is valid Markdown
2. Verify mdpdf can process the file manually
3. Check for special characters or formatting issues

### Manual PDF conversion
You can manually convert any Markdown file to PDF:
```bash
mdpdf "path/to/file.md" -o "path/to/output.pdf"
```

## Benefits

- **Automatic workflow:** No manual PDF generation needed
- **Consistent formatting:** All PDFs use mdpdf's formatting
- **Version control:** PDFs are automatically committed with source changes
- **Simple pipeline:** Single commit updates MD and PDF versions

## Customization

To modify PDF output settings, you can:
1. Add additional mdpdf options (see `mdpdf --help`)
2. Modify the output directory structure if needed

## Status Messages

The hook provides clear status messages:
- 🔄 "Converting Markdown to PDF: filename.md"
- ✅ "Successfully converted to: Szenen/pdf/filename.pdf" 
- ❌ "Failed to convert Markdown to PDF: filename.md"
- 📊 Summary with conversion counts and error counts

## Integration with Existing Workflow

This feature seamlessly extends the existing workflow:
- No changes needed to existing `.md` files
- PDF generation is an additional step that doesn't interfere with existing processes
- All files (.md, .pdf) remain in sync automatically

---
**Note:**  
Previous workflows using Fountain and screenplain are no longer used.  
All conversion is now handled directly from Markdown to PDF via mdpdf.