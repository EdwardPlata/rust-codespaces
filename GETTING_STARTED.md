# 🚀 Getting Started with Rust Development

Welcome to your comprehensive Rust development environment! This guide will help you get started quickly.

## 📋 Prerequisites

The development environment is already set up in this Codespace with:

- Rust toolchain (stable)
- All essential Rust tools
- VS Code extensions
- Example projects

## 🏃‍♂️ Quick Start

### 1. Test Your Environment

```bash
# Check Rust installation
rustc --version
cargo --version

# Run a simple example
cd examples/hello_world
cargo run
```

### 2. Explore Example Projects

```bash
# Navigate to examples directory
cd examples

# List available projects
ls -la

# Run different examples
cargo run -p hello_world    # Basic async example
cargo run -p web_server     # Web server with Axum
cargo run -p cli_tool -- greet --name "Your Name"  # CLI tool
```

### 3. Run Tests

```bash
# Run all tests
cargo test

# Run tests for a specific project
cargo test -p my_lib

# Run tests in watch mode
cargo watch -x test
```

## 🛠️ Development Workflows

### Building Projects

```bash
# Build all projects
make build

# Build specific project
cargo build -p hello_world

# Build for release
cargo build --release
```

### Code Quality

```bash
# Format code
make fmt
# or
cargo fmt

# Run linter
make clippy
# or
cargo clippy

# Run all quality checks
make check-all
```

### Web Development

```bash
# Start the web server
make run-web
# or
cargo run -p web_server

# The server will be available at http://localhost:3000
```

### WASM Development

```bash
# Build WASM project
make wasm-build

# Serve WASM example locally
make wasm-serve

# Open http://localhost:8000 to see the WASM demo
```

### CLI Development

```bash
# Run CLI examples
make run-cli-greet NAME="Rust Developer"
make run-cli-factorial NUM=10

# Or use cargo directly
cargo run -p cli_tool -- greet --name "World" --count 3
cargo run -p cli_tool -- factorial 8
cargo run -p cli_tool -- file create test.json --content "Hello Rust!"
```

## 🔧 Available Tools

### Cargo Tools

- `cargo-watch` - Auto-reload on file changes
- `cargo-edit` - Add/remove dependencies
- `cargo-tree` - Show dependency tree
- `cargo-audit` - Security vulnerability scanner
- `cargo-outdated` - Check for outdated dependencies

### Performance Tools

- `flamegraph` - Generate flame graphs
- `hyperfine` - Benchmark commands
- `criterion` - Micro-benchmarking (available in my_lib)

### WASM Tools

- `wasm-pack` - Build Rust-generated WebAssembly
- `trunk` - WASM web application bundler

### Database Tools

- `sqlx-cli` - SQLx command-line tool
- `diesel_cli` - Diesel ORM tool

## 🎯 VS Code Features

### Debugging

1. Set breakpoints in your Rust code
2. Press `F5` or use "Run and Debug"
3. Choose the appropriate debug configuration

### Tasks

Available VS Code tasks (Ctrl+Shift+P → "Run Task"):

- `cargo: build` - Build the project
- `cargo: run` - Run the project
- `cargo: test` - Run tests
- `cargo: clippy` - Run linter
- `cargo: fmt` - Format code
- `cargo: watch run` - Auto-reload on changes
- `cargo: watch test` - Auto-reload tests

### Extensions

Your environment includes:

- `rust-analyzer` - Rust language server
- `CodeLLDB` - Native debugger
- `crates` - Dependency management
- `Even Better TOML` - Enhanced TOML support

## 📚 Learning Resources

### Example Projects Included

1. **hello_world** - Basic binary with async/await and serde
2. **my_lib** - Library with tests and benchmarks
3. **web_server** - REST API using Axum framework
4. **cli_tool** - Command-line application using clap
5. **wasm_example** - WebAssembly with browser integration

### Next Steps

1. **Create your own project:**

   ```bash
   cargo new my_awesome_project
   cd my_awesome_project
   cargo run
   ```

2. **Add dependencies:**

   ```bash
   cargo add serde --features derive
   cargo add tokio --features full
   ```

3. **Try different project types:**
   ```bash
   cargo new my_lib --lib        # Library
   cargo new my_bin --bin        # Binary
   ```

## 🐛 Troubleshooting

### Common Issues

1. **Rust analyzer not working:**

   - Restart VS Code
   - Run `cargo check` to ensure project compiles

2. **Tests failing:**

   - Check dependencies in `Cargo.toml`
   - Run `cargo update` to update dependencies

3. **Performance issues:**
   - Use `cargo build --release` for optimized builds
   - Profile with `cargo flamegraph`

### Getting Help

- Use `cargo --help` for Cargo commands
- Use `rustc --help` for compiler options
- Check the [Rust Book](https://doc.rust-lang.org/book/)
- Visit the [Rust Community](https://www.rust-lang.org/community)

## 🎉 Happy Coding!

Your Rust development environment is ready! Start building amazing things with Rust! 🦀✨

For more advanced usage, check out the main README.md file.
