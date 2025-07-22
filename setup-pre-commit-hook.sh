#!/bin/bash

# Setup script to install the pre-commit hook for automatic Fountain and PDF conversion
# This script copies the pre-commit hook to the correct Git hooks directory

set -e  # Exit on any error

echo "🎭 Theater Script Pre-Commit Hook Setup"
echo "======================================"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR"

# Check if we're in a Git repository
if [ ! -d "$PROJECT_ROOT/.git" ]; then
    echo "❌ Error: This is not a Git repository."
    echo "Please run this script from the root of your Git repository."
    exit 1
fi

# Check if the pre-commit hook file exists
PRE_COMMIT_HOOK_SOURCE="$PROJECT_ROOT/pre-commit-hook.sh"
if [ ! -f "$PRE_COMMIT_HOOK_SOURCE" ]; then
    echo "❌ Error: pre-commit-hook.sh not found in project root."
    echo "Please ensure pre-commit-hook.sh exists before running setup."
    exit 1
fi

# Check if the converter script exists
CONVERTER_SCRIPT="$PROJECT_ROOT/md_to_fountain.py"
if [ ! -f "$CONVERTER_SCRIPT" ]; then
    echo "❌ Error: md_to_fountain.py not found in project root."
    echo "Please ensure the converter script exists before setting up the hook."
    exit 1
fi

# Check if screenplain is available for PDF conversion
if ! command -v screenplain &> /dev/null; then
    echo "⚠️  Warning: screenplain is not installed or not in PATH"
    echo "   PDF conversion will not work without screenplain."
    echo "   Install it with: pip install screenplain"
    echo ""
    read -p "Do you want to continue anyway? (y/N): " -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Setup cancelled."
        echo "Please install screenplain first: pip install screenplain"
        exit 1
    fi
    echo "⚠️  Continuing without screenplain - PDF conversion will fail until installed."
else
    echo "✅ screenplain found - PDF conversion will work."
fi

# Git hooks directory
HOOKS_DIR="$PROJECT_ROOT/.git/hooks"
PRE_COMMIT_HOOK_TARGET="$HOOKS_DIR/pre-commit"

# Create hooks directory if it doesn't exist
if [ ! -d "$HOOKS_DIR" ]; then
    echo "📁 Creating Git hooks directory..."
    mkdir -p "$HOOKS_DIR"
fi

# Check if a pre-commit hook already exists
if [ -f "$PRE_COMMIT_HOOK_TARGET" ]; then
    echo "⚠️  A pre-commit hook already exists."
    echo "Current hook:"
    echo "   $(ls -la "$PRE_COMMIT_HOOK_TARGET")"
    echo ""
    read -p "Do you want to replace it? (y/N): " -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Setup cancelled."
        exit 1
    fi

    # Backup existing hook
    BACKUP_FILE="$PRE_COMMIT_HOOK_TARGET.backup.$(date +%Y%m%d_%H%M%S)"
    echo "📦 Backing up existing hook to: $(basename "$BACKUP_FILE")"
    cp "$PRE_COMMIT_HOOK_TARGET" "$BACKUP_FILE"
fi

# Copy the pre-commit hook
echo "📋 Installing pre-commit hook..."
cp "$PRE_COMMIT_HOOK_SOURCE" "$PRE_COMMIT_HOOK_TARGET"

# Make the hook executable
chmod +x "$PRE_COMMIT_HOOK_TARGET"

# Verify the installation
echo "🔍 Verifying installation..."
if [ -x "$PRE_COMMIT_HOOK_TARGET" ]; then
    echo "   ✅ Hook is executable"
else
    echo "   ❌ Hook is not executable"
    exit 1
fi

echo "✅ Pre-commit hook installed successfully!"
echo ""
echo "📋 Hook Details:"
echo "   - Source: $(basename "$PRE_COMMIT_HOOK_SOURCE")"
echo "   - Target: .git/hooks/pre-commit"
echo "   - Permissions: $(ls -la "$PRE_COMMIT_HOOK_TARGET" | cut -d' ' -f1)"
echo ""
echo "🎯 What this hook does:"
echo "   - Runs automatically before each commit"
echo "   - Converts all staged .md files in Szenen/ to Fountain format"
echo "   - Converts Fountain files to PDF using screenplain"
echo "   - Skips .meta.md files"
echo "   - Saves converted files to Szenen/fountain/ and Szenen/pdf/"
echo "   - Automatically stages the converted .fountain and .pdf files"
echo ""
echo "🧪 Testing the hook:"
echo "   You can test the hook by staging a .md file in Szenen/ and committing:"
echo "   git add Szenen/test.md"
echo "   git commit -m 'Test commit'"
echo ""
echo "🔧 To disable the hook temporarily:"
echo "   git commit --no-verify -m 'Your message'"
echo ""
echo "🗑️  To remove the hook:"
echo "   rm .git/hooks/pre-commit"
echo ""
echo "🎉 Setup complete! The hook will now run on every commit."
