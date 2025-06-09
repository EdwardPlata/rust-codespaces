# 🦀 Rust Development Codespaces

A comprehensive, production-ready Rust development environment for GitHub Codespaces with all the tools you need to build amazing Rust applications.

## 🚀 What's Included

This environment comes pre-configured with everything you need for modern Rust development:

### 🦀 Rust Toolchain & Components

- **Rust Stable Toolchain**: Latest stable Rust compiler and standard library
- **rustfmt**: Code formatting tool
- **Clippy**: Rust linter for catching common mistakes and improving code
- **rust-analyzer**: Powerful language server for IDE features
- **rust-src**: Rust source code for better IDE integration
- **WASM target**: `wasm32-unknown-unknown` for WebAssembly development

### 🛠️ Development Tools

- **cargo-watch**: Automatically run commands when files change
- **cargo-edit**: Add, remove, and upgrade dependencies from the command line
- **cargo-tree**: Display dependency trees
- **cargo-audit**: Security vulnerability scanner
- **cargo-outdated**: Check for outdated dependencies
- **cargo-expand**: Show macro-expanded code
- **cargo-bloat**: Find what takes most space in your executable
- **cargo-deps**: Build dependency graphs
- **cargo-generate**: Generate projects from templates

### 🌐 Web & WASM Development

- **wasm-pack**: Build Rust-generated WebAssembly
- **trunk**: WASM web application bundler
- **Node.js**: For web development and tooling

### 🗄️ Database Tools

- **sqlx-cli**: SQLx command-line tool for database migrations
- **diesel_cli**: Diesel ORM command-line tool (PostgreSQL & SQLite support)

### 📊 Performance & Debugging

- **tokio-console**: Debugger for async Rust programs
- **flamegraph**: Generate flame graphs for performance analysis
- **hyperfine**: Command-line benchmarking tool
- **LLDB**: Native debugger integration

### 🔧 System Tools

- **ripgrep**: Ultra-fast text search
- **fd-find**: Fast and user-friendly alternative to find
- **bat**: Syntax-highlighted file viewer
- **exa**: Modern replacement for ls
- **starship**: Customizable shell prompt
- **Git**: Version control
- **GitHub CLI**: GitHub integration
- **Docker**: Container support
- **CMake & Clang**: For C/C++ interop

### 🎨 VS Code Extensions

- **rust-analyzer**: Rust language server
- **CodeLLDB**: Native debugger
- **crates**: Manage Rust dependencies
- **Even Better TOML**: Enhanced TOML support
- **Rust Syntax**: Additional syntax highlighting
- **Dependi**: Dependency management
- **GitHub Pull Requests**: GitHub integration
- **Docker**: Container development
- **Live Share**: Collaborative editing
- **IntelliCode**: AI-assisted development

## 📁 Example Projects

The environment comes with pre-configured example projects in `/workspace/examples/`:

- **hello_world**: Simple binary application
- **my_lib**: Library crate with tests
- **rust_workspace**: Multi-crate workspace example

## 🚀 Quick Start

### 1. Create Your Codespace

Click the "Use this template" button or create a new Codespace from this repository.

### 2. Wait for Setup

The environment will automatically install all Rust tools and dependencies. This takes a few minutes on first setup.

### 3. Start Coding!

```bash
# Navigate to examples
cd /workspace/examples/hello_world

# Run the hello world example
cargo run

# Run tests
cargo test

# Check your code
cargo clippy

# Format your code
cargo fmt

# Start developing with auto-reload
cargo watch -x run
```

### 4. Create a New Project

```bash
# Create a new binary project
cargo new my_awesome_project

# Or create from a template
cargo generate --git https://github.com/rust-starter/rust-starter

# Create a new library
cargo new my_library --lib
```

## 🔧 Advanced Usage

### WebAssembly Development

```bash
# Create a new WASM project
cargo new --lib my-wasm-project
cd my-wasm-project

# Add WASM dependencies to Cargo.toml
# Then build for WASM
wasm-pack build --target web

# Or use trunk for full web apps
trunk serve
```

### Database Development

```bash
# SQLx setup
cargo install sqlx-cli
sqlx database create
sqlx migrate add initial

# Diesel setup
diesel setup
diesel migration generate create_users
```

### Performance Analysis

```bash
# Benchmark your code
cargo install criterion
# Add criterion to your Cargo.toml, then:
cargo bench

# Profile with flamegraph
cargo flamegraph --bin my-binary

# Benchmark commands
hyperfine 'cargo run --release'
```

## 🎯 Debugging

The environment includes full debugging support:

1. Set breakpoints in VS Code
2. Press F5 or use "Run and Debug"
3. Use the integrated LLDB debugger
4. Debug async code with tokio-console

## 🔍 Code Quality

Built-in code quality tools:

```bash
# Lint your code
cargo clippy

# Format your code
cargo fmt

# Security audit
cargo audit

# Check for outdated dependencies
cargo outdated

# Analyze binary size
cargo bloat --release
```

## 🌐 Port Forwarding

The following ports are pre-configured for forwarding:

- **3000**: Development servers (Trunk, etc.)
- **8080**: Web servers
- **8000**: HTTP servers

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues and enhancement requests.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Happy Rust coding! 🦀✨**
