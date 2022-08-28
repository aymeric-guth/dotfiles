#!/bin/sh
cargo install --git https://github.com/matthiaskrgr/cargo-cache cargo-cache --locked || exit 1
cargo install --git https://github.com/tamasfe/taplo taplo-cli --features lsp --locked || exit 1
cargo install --git https://github.com/BurntSushi/ripgrep ripgrep --locked || exit 1
cargo install --git https://github.com/sharkdp/fd fd-find --locked || exit 1
cargo install --git https://github.com/JohnnyMorganz/StyLua stylua --features lua52 --locked || exit 1
cargo install --git https://github.com/tree-sitter/tree-sitter tree-sitter-cli --locked || exit 1
# markdown lnatural language linter
cargo install --git https://github.com/lukas-reineke/cbfmt cbfmt --locked || exit 1
# utilisation de LIBSSH2_SYS_USE_PKG_CONFIG pour palier a une erreur de linker
LIBSSH2_SYS_USE_PKG_CONFIG=whatever cargo install --git https://github.com/nabijaczleweli/cargo-update --locked || exit 1
cargo install --git https://github.com/sharkdp/bat bat --locked || exit 1
cargo install --git https://github.com/dduan/tre tre-command --locked || exit 1
cargo install --git https://github.com/Peltoche/lsd.git --branch master || exit 1
