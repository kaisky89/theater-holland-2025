#!/bin/bash

# Pre-commit hook to automatically convert Markdown theater scripts to Fountain format
# This script runs before each commit and converts all modified .md files in the Szenen directory

set -e  # Exit on any error

echo "🎭 Theater Script Pre-Commit Hook"
echo "================================="

# Get the directory where this script is located (inside .git/hooks/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Go up two levels to get to project root (.git/hooks -> .git -> project root)
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../" && pwd)"

# Python converter script path
CONVERTER_SCRIPT="$PROJECT_ROOT/md_to_fountain.py"

# Check if converter script exists
if [ ! -f "$CONVERTER_SCRIPT" ]; then
    echo "❌ Error: Converter script not found at $CONVERTER_SCRIPT"
    echo "Please ensure md_to_fountain.py is in the project root."
    exit 1
fi

# Check if Szenen directory exists
SZENEN_DIR="$PROJECT_ROOT/Szenen"
if [ ! -d "$SZENEN_DIR" ]; then
    echo "⚠️  Warning: Szenen directory not found. Creating it..."
    mkdir -p "$SZENEN_DIR"
fi

# Get list of staged .md files in Szenen directory
STAGED_MD_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep '^Szenen/.*\.md$' | grep -v '\.meta\.md$' || true)

if [ -z "$STAGED_MD_FILES" ]; then
    echo "ℹ️  No Markdown theater scripts to convert."
    exit 0
fi

echo "📝 Found staged Markdown files:"
echo "$STAGED_MD_FILES" | sed 's/^/   - /'

# Create fountain output directory if it doesn't exist
FOUNTAIN_DIR="$PROJECT_ROOT/Szenen/fountain"
if [ ! -d "$FOUNTAIN_DIR" ]; then
    echo "📁 Creating fountain output directory..."
    mkdir -p "$FOUNTAIN_DIR"
fi

# Convert each staged .md file
CONVERTED_COUNT=0
CONVERSION_ERRORS=0

for md_file in $STAGED_MD_FILES; do
    if [ -f "$PROJECT_ROOT/$md_file" ]; then
        echo "🔄 Converting: $md_file"

        # Get the base name without extension
        base_name=$(basename "$md_file" .md)
        fountain_file="$FOUNTAIN_DIR/${base_name}.fountain"

        # Run the conversion
        if python3 "$CONVERTER_SCRIPT" "$PROJECT_ROOT/$md_file" "$fountain_file"; then
            echo "✅ Successfully converted to: Szenen/fountain/${base_name}.fountain"

            # Stage the converted fountain file
            git add "$fountain_file"
            CONVERTED_COUNT=$((CONVERTED_COUNT + 1))
        else
            echo "❌ Failed to convert: $md_file"
            CONVERSION_ERRORS=$((CONVERSION_ERRORS + 1))
        fi
    else
        echo "⚠️  Warning: File not found: $md_file"
    fi
done

echo ""
echo "📊 Conversion Summary:"
echo "   - Files converted: $CONVERTED_COUNT"
echo "   - Conversion errors: $CONVERSION_ERRORS"

# Exit with error if there were conversion failures
if [ $CONVERSION_ERRORS -gt 0 ]; then
    echo ""
    echo "❌ Some conversions failed. Please check the errors above."
    echo "Fix the issues and try committing again."
    exit 1
fi

if [ $CONVERTED_COUNT -gt 0 ]; then
    echo ""
    echo "🎉 All theater scripts successfully converted to Fountain format!"
    echo "   The converted .fountain files have been staged for commit."
fi

echo ""
echo "✅ Pre-commit hook completed successfully."
