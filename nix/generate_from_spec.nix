{pkgs, oas3-gen}: let
  SPEC_URL = "https://raw.githubusercontent.com/openresponses/openresponses/refs/heads/main/public/openapi/openapi.json";
in
  pkgs.writeShellScriptBin "generate_from_spec" ''
    ${pkgs.curl}/bin/curl ${SPEC_URL} > /tmp/openapi.json
    cat /tmp/openapi.json

    ${oas3-gen}/bin/oas3-gen generate -i /tmp/openapi.json -o src/types.rs
  ''
