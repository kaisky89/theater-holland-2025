#!/bin/bash

# Pre-commit hook to automatically convert Markdown theater scripts to PDF using mdpdf
# This script runs before each commit and converts all modified .md files in the Szenen directory (excluding .meta.md)

set -e  # Exit on any error

echo "🎭 Theater Script Pre-Commit Hook (Markdown → PDF via mdpdf)"
echo "============================================================"

# Get the directory where this script is located (inside .git/hooks/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Go up two levels to get to project root (.git/hooks -> .git -> project root)
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../" && pwd)"

# Check if Szenen directory exists
SZENEN_DIR="$PROJECT_ROOT/Szenen"
if [ ! -d "$SZENEN_DIR" ]; then
    echo "⚠️  Warning: Szenen directory not found. Creating it..."
    mkdir -p "$SZENEN_DIR"
fi

# Check if mdpdf is available
if ! command -v mdpdf &> /dev/null; then
    echo "❌ Error: mdpdf is not installed or not in PATH"
    echo "Please install mdpdf: npm install -g mdpdf"
    exit 1
fi

# Get list of staged .md files in Szenen directory (using null-terminated strings to handle spaces)
STAGED_MD_FILES=()
while IFS= read -r -d '' file; do
    STAGED_MD_FILES+=("$file")
done < <(git diff --cached --name-only -z --diff-filter=ACM | grep -z '^Szenen/.*\.md$' | grep -z -v '\.meta\.md$' || true)

if [ ${#STAGED_MD_FILES[@]} -eq 0 ]; then
    echo "ℹ️  No Markdown theater scripts to convert."
    exit 0
fi

echo "📝 Found staged Markdown files:"
for file in "${STAGED_MD_FILES[@]}"; do
    echo "   - $file"
done

# Create PDF output directory if it doesn't exist
PDF_DIR="$PROJECT_ROOT/Szenen/pdf"
if [ ! -d "$PDF_DIR" ]; then
    echo "📁 Creating PDF output directory..."
    mkdir -p "$PDF_DIR"
fi

# Convert each staged .md file to PDF using mdpdf
PDF_CONVERTED_COUNT=0
PDF_CONVERSION_ERRORS=0

for md_file in "${STAGED_MD_FILES[@]}"; do
    if [ -f "$PROJECT_ROOT/$md_file" ]; then
        echo "🔄 Converting Markdown to PDF: $md_file"

        # Get the base name without extension
        base_name=$(basename "$md_file" .md)
        pdf_file="$PDF_DIR/${base_name}.pdf"
        pdf_in_szenen="$SZENEN_DIR/${base_name}.pdf"

        # Run the Markdown to PDF conversion (output will be in Szenen/)
        if mdpdf "$PROJECT_ROOT/$md_file"; then
            # Move the PDF to Szenen/pdf/, overwrite if exists
            if [ -f "$pdf_in_szenen" ]; then
                mv -f "$pdf_in_szenen" "$pdf_file"
                echo "✅ PDF moved to: Szenen/pdf/${base_name}.pdf"
            else
                echo "❌ PDF was not created in Szenen/: $pdf_in_szenen"
                PDF_CONVERSION_ERRORS=$((PDF_CONVERSION_ERRORS + 1))
                continue
            fi

            # Stage the converted PDF file
            git add "$pdf_file"
            PDF_CONVERTED_COUNT=$((PDF_CONVERTED_COUNT + 1))
        else
            echo "❌ Failed to convert Markdown to PDF: $md_file"
            PDF_CONVERSION_ERRORS=$((PDF_CONVERSION_ERRORS + 1))
        fi
    else
        echo "⚠️  Warning: File not found: $md_file"
    fi
done

echo ""
echo "📊 Conversion Summary:"
echo "   - Markdown to PDF files converted: $PDF_CONVERTED_COUNT"
echo "   - Markdown to PDF conversion errors: $PDF_CONVERSION_ERRORS"

# Exit with error if there were conversion failures
if [ $PDF_CONVERSION_ERRORS -gt 0 ]; then
    echo ""
    echo "❌ Some conversions failed. Please check the errors above."
    echo "Fix the issues and try committing again."
    exit 1
fi

if [ $PDF_CONVERTED_COUNT -gt 0 ]; then
    echo ""
    echo "🎉 All theater scripts successfully converted!"
    echo "   - .pdf files have been staged for commit."
fi

echo ""
echo "✅ Pre-commit hook completed successfully."
