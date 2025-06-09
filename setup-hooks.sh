#!/bin/bash

# Setup Git hooks for Rust development

echo "🔧 Setting up Git hooks for Rust development..."

# Check if we're in a Git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Not in a Git repository"
    exit 1
fi

# Get the Git hooks directory
HOOKS_DIR="$(git rev-parse --git-dir)/hooks"
PROJECT_HOOKS_DIR="$(git rev-parse --show-toplevel)/.githooks"

echo "📁 Git hooks directory: $HOOKS_DIR"
echo "📁 Project hooks directory: $PROJECT_HOOKS_DIR"

# Copy pre-commit hook
if [ -f "$PROJECT_HOOKS_DIR/pre-commit" ]; then
    cp "$PROJECT_HOOKS_DIR/pre-commit" "$HOOKS_DIR/pre-commit"
    chmod +x "$HOOKS_DIR/pre-commit"
    echo "✅ Pre-commit hook installed"
else
    echo "❌ Pre-commit hook not found in $PROJECT_HOOKS_DIR"
    exit 1
fi

echo ""
echo "🎉 Git hooks setup complete!"
echo ""
echo "The pre-commit hook will now run before each commit to:"
echo "  - Check Cargo.toml syntax"
echo "  - Run cargo check"
echo "  - Run tests"
echo "  - Run clippy"
echo "  - Check/fix formatting"
echo ""
echo "To skip hooks for a commit (not recommended):"
echo "  git commit --no-verify"
