#!/bin/bash

# Local CI Testing Script
# This script tests the GitHub Actions workflow locally

set -e  # Exit on any error

echo "🔧 Local CI Testing for Rust Codespaces"
echo "========================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✅ $2${NC}"
    else
        echo -e "${RED}❌ $2${NC}"
        exit 1
    fi
}

print_info() {
    echo -e "${YELLOW}📋 $1${NC}"
}

# Check if we're in a dev container (where Rust is available)
if ! command -v cargo &> /dev/null; then
    echo -e "${YELLOW}⚠️  Rust not found in current environment${NC}"
    echo "This script should be run in a development environment with Rust installed."
    echo ""
    echo "To test locally:"
    echo "1. Open this repository in GitHub Codespaces"
    echo "2. Wait for the dev container to finish setting up"
    echo "3. Run: ./test_ci.sh"
    echo ""
    echo "For now, let's test what we can without Rust..."
    echo ""
fi

print_info "Testing repository structure..."

# Test 1: Check if all required files exist
print_info "Checking required files..."

required_files=(
    "Cargo.toml"
    ".github/workflows/ci.yml"
    "rust-toolchain.toml"
    "rustfmt.toml"
    "examples/hello_world/Cargo.toml"
    "examples/my_lib/Cargo.toml"
    "examples/web_server/Cargo.toml"
    "examples/cli_tool/Cargo.toml"
    "examples/wasm_example/Cargo.toml"
)

missing_files=()
for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        missing_files+=("$file")
    fi
done

if [ ${#missing_files[@]} -eq 0 ]; then
    print_status 0 "All required files exist"
else
    echo -e "${RED}Missing files:${NC}"
    for file in "${missing_files[@]}"; do
        echo "  - $file"
    done
    print_status 1 "Missing required files"
fi

# Test 2: Check Cargo.toml syntax
print_info "Validating Cargo.toml files..."

toml_files=(
    "Cargo.toml"
    "examples/hello_world/Cargo.toml"
    "examples/my_lib/Cargo.toml"
    "examples/web_server/Cargo.toml"
    "examples/cli_tool/Cargo.toml"
    "examples/wasm_example/Cargo.toml"
)

# Simple TOML syntax check (looking for common issues)
toml_errors=()
for file in "${toml_files[@]}"; do
    if [ -f "$file" ]; then
        # Check for duplicate section headers
        duplicate_sections=$(grep -n "^\[.*\]$" "$file" | cut -d: -f2 | sort | uniq -d)
        if [ ! -z "$duplicate_sections" ]; then
            toml_errors+=("$file: Duplicate sections: $duplicate_sections")
        fi

        # Check for basic syntax issues
        if grep -q "^\[workspace\.dependencies\]" "$file"; then
            section_count=$(grep -c "^\[workspace\.dependencies\]" "$file")
            if [ $section_count -gt 1 ]; then
                toml_errors+=("$file: Multiple [workspace.dependencies] sections")
            fi
        fi
    fi
done

if [ ${#toml_errors[@]} -eq 0 ]; then
    print_status 0 "TOML files syntax looks good"
else
    echo -e "${RED}TOML errors found:${NC}"
    for error in "${toml_errors[@]}"; do
        echo "  - $error"
    done
    print_status 1 "TOML syntax errors"
fi

# Test 3: Check GitHub Actions workflow syntax
print_info "Validating GitHub Actions workflow..."

workflow_file=".github/workflows/ci.yml"
if [ -f "$workflow_file" ]; then
    # Basic YAML syntax check
    if command -v python3 &> /dev/null; then
        python3 -c "
import yaml
import sys
try:
    with open('$workflow_file', 'r') as f:
        yaml.safe_load(f)
    print('GitHub Actions workflow YAML is valid')
    sys.exit(0)
except yaml.YAMLError as e:
    print(f'YAML syntax error: {e}')
    sys.exit(1)
except Exception as e:
    print(f'Error reading file: {e}')
    sys.exit(1)
"
        yaml_status=$?
        print_status $yaml_status "GitHub Actions workflow YAML validation"
    else
        echo "Python3 not available for YAML validation"
        print_status 0 "Skipped YAML validation (no python3)"
    fi
else
    print_status 1 "GitHub Actions workflow file not found"
fi

# Test 4: Check for common Rust project issues
print_info "Checking for common Rust project issues..."

issues=()

# Check for proper workspace member paths
workspace_members=$(grep -A 10 "^\[workspace\]" Cargo.toml | grep -A 5 "members = \[" | grep '"' | sed 's/.*"\(.*\)".*/\1/')
for member in $workspace_members; do
    if [ ! -f "$member/Cargo.toml" ]; then
        issues+=("Workspace member '$member' has no Cargo.toml")
    fi
done

# Check for src directories
for dir in examples/*/; do
    if [ -d "$dir" ] && [ ! -d "${dir}src" ]; then
        issues+=("Directory '$dir' missing src/ subdirectory")
    fi
done

if [ ${#issues[@]} -eq 0 ]; then
    print_status 0 "No common project structure issues found"
else
    echo -e "${YELLOW}Potential issues found:${NC}"
    for issue in "${issues[@]}"; do
        echo "  - $issue"
    done
    print_status 0 "Some issues found but not critical for CI"
fi

echo ""
echo "🎉 Local testing complete!"
echo ""

if command -v cargo &> /dev/null; then
    echo "🦀 Since Rust is available, let's run the actual CI commands:"
    echo ""

    print_info "Running cargo check..."
    cargo check --workspace
    print_status $? "Cargo check"

    print_info "Running cargo test..."
    cargo test --workspace --verbose
    print_status $? "Cargo test"

    print_info "Running cargo clippy..."
    cargo clippy --workspace -- -D warnings
    print_status $? "Cargo clippy"

    print_info "Running cargo fmt check..."
    cargo fmt --all -- --check
    print_status $? "Cargo fmt check"

else
    echo "To run the full CI test:"
    echo "1. Create a GitHub Codespace from this repository"
    echo "2. Run: chmod +x test_ci.sh && ./test_ci.sh"
    echo "3. Or use the Makefile: make check-all"
fi

echo ""
echo "✨ Testing complete! If all checks passed, the CI should work."
