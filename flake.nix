{
  description = "Flake for lfest-rs";

  inputs = {
    nixpks.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    hongdown.url = "github:dahlia/hongdown";
  };

  outputs = {
    nixpkgs,
    rust-overlay,
    flake-utils,
    hongdown,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        overlays = [(import rust-overlay)];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        rust = pkgs.rust-bin.stable.latest.default;
      in
        with pkgs; {
          devShells.default = mkShell {
            buildInputs = [
              (lib.hiPrio rust-bin.nightly."2026-01-01".rustfmt)
              rust
              cargo-nextest
              cargo-semver-checks
              cargo-machete
              taplo
              hongdown.packages.${system}.hongdown
              openssl
              pkg-config
            ];
            RUST_BACKTRACE = "1";
          };
        }
    );
}
