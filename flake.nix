{
  description = "Flake for lfest-rs";

  inputs = {
    nixpks.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    hongdown.url = "github:dahlia/hongdown";
    oas3-gen.url = "github:MathisWellmann/oas3-gen";
  };

  outputs = {
    nixpkgs,
    rust-overlay,
    flake-utils,
    hongdown,
    oas3-gen,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        overlays = [(import rust-overlay)];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        rust = pkgs.rust-bin.selectLatestNightlyWith (
            toolchain: toolchain.default
          );
        oas3 = oas3-gen.packages.${system}.oas3-gen;
      in
        with pkgs; {
          devShells.default = mkShell {
            buildInputs = [
              rust
              cargo-semver-checks
              cargo-machete
              taplo
              hongdown.packages.${system}.hongdown
              oas3
            ];
            RUST_BACKTRACE = "1";
          };
          apps = rec {
            default = generate_from_spec;
            generate_from_spec = flake-utils.lib.mkApp {
              drv = import nix/generate_from_spec.nix {inherit pkgs oas3 rust;};
            };
          };
        }
    );
}
