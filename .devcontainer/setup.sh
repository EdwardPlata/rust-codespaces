#!/bin/bash

# Update system and install essential packages
apt-get update && apt-get upgrade -y
apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    pkg-config \
    libssl-dev \
    libsqlite3-dev \
    cmake \
    lldb \
    clang \
    jq \
    sudo \
    zsh \
    unzip \
    tree \
    htop \
    vim \
    nano

# Install Rust toolchain (latest stable)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable
source ~/.cargo/env

# Add Rust toolchain to PATH for all users
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> /etc/bash.bashrc
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> /etc/zsh/zshrc

# Install additional Rust components
rustup component add rustfmt clippy rust-src rust-analyzer
rustup target add wasm32-unknown-unknown

# Install useful Rust tools
cargo install cargo-watch
cargo install cargo-edit
cargo install cargo-tree
cargo install cargo-audit
cargo install cargo-outdated
cargo install cargo-expand
cargo install cargo-bloat
cargo install cargo-deps
cargo install cargo-generate
cargo install wasm-pack
cargo install trunk
cargo install sqlx-cli
cargo install diesel_cli --no-default-features --features postgres,sqlite
cargo install tokio-console
cargo install flamegraph
cargo install hyperfine
cargo install ripgrep
cargo install fd-find
cargo install bat
cargo install exa
cargo install starship

# Install Node.js and npm (for web development with Rust)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
apt-get install -y nodejs

# Install additional development tools
npm install -g wasm-pack

# Setup Starship prompt
echo 'eval "$(starship init bash)"' >> /etc/bash.bashrc
echo 'eval "$(starship init zsh)"' >> /etc/zsh/zshrc

# Create a sample Rust project structure
mkdir -p /workspace/examples
cd /workspace/examples

# Create a simple "Hello World" Rust project
cargo new hello_world --bin
cd hello_world
echo 'fn main() {
    println!("🦀 Welcome to your Rust development environment!");
    println!("Happy coding! 🚀");
}' > src/main.rs

# Create a library example
cd /workspace/examples
cargo new my_lib --lib
cd my_lib
echo 'pub fn add(left: usize, right: usize) -> usize {
    left + right
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = add(2, 2);
        assert_eq!(result, 4);
    }
}' > src/lib.rs

# Create a workspace example
cd /workspace/examples
mkdir rust_workspace
cd rust_workspace
echo '[workspace]
members = [
    "hello_world",
    "my_lib",
]

[workspace.dependencies]
serde = { version = "1.0", features = ["derive"] }
tokio = { version = "1.0", features = ["full"] }' > Cargo.toml

# Move the previously created projects into the workspace
mv ../hello_world .
mv ../my_lib .

# Update hello_world to use workspace dependencies
echo '[package]
name = "hello_world"
version = "0.1.0"
edition = "2021"

[dependencies]
serde = { workspace = true }' > hello_world/Cargo.toml

echo '[package]
name = "my_lib"
version = "0.1.0"
edition = "2021"

[dependencies]
serde = { workspace = true }' > my_lib/Cargo.toml

# Set proper permissions
chmod -R 755 /workspace
chown -R vscode:vscode /workspace || true

# Clean up temporary files
apt-get autoremove -y
apt-get autoclean
rm -rf /var/lib/apt/lists/*

echo "🦀 Rust development environment setup complete!"
echo "=================================="
echo "Available tools:"
echo "  - Rust toolchain (stable) with rustfmt, clippy, rust-analyzer"
echo "  - Cargo tools: watch, edit, tree, audit, outdated, expand, bloat, deps, generate"
echo "  - WASM tools: wasm-pack, trunk"
echo "  - Database tools: sqlx-cli, diesel_cli"
echo "  - Performance tools: tokio-console, flamegraph, hyperfine"
echo "  - CLI tools: ripgrep, fd-find, bat, exa"
echo "  - Starship prompt"
echo ""
echo "Example projects created in /workspace/examples/"
echo ""
echo "Quick start:"
echo "  cd examples/hello_world && cargo run"
echo "  cd examples/web_server && cargo run"
echo "  make help  # See all available commands"
echo ""
echo "Happy coding! 🚀"
