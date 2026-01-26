{
  lib,
  rustPlatform,
  fetchFromGitHub,
  openssl,
  pkg-config,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "oas3-gen";
  version = "release/0.24.0";

  nativeBuildInputs = [
    openssl
    pkg-config
  ];
  buildInputs = [
    openssl
    pkg-config
  ];

  src = fetchFromGitHub {
    owner = "eklipse2k8";
    repo = "oas3-gen";
    tag = finalAttrs.version;
    hash = "sha256-wsN2KIZ5O8mEuP12sTkOvb+tqcH1vPRZQUlcUY0Aumk=";
  };
  cargoHash = "sha256-NDxXPjUtKTbdiYWXI/18rRuyK4GMtKl6LCUR78wWAf0=";
  meta = {
    description = "Rust OpenAPI 3.1 Type Generator";
    mainProgram = "oas3-gen";
    homepage = "https://github.com/eklipse2k8/oas3-gen";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ wellmannmathis ];
  };
})
