OpenResponses Rust Types
========================

This repo contains automatically generated rust types for the [OpenResponses]
API specification, which is available as an OpenAPI 3.1 spec. Generation is
done using [oas3-gen]

To generate the types yourself from the newest HEAD of `main`:

 -  Make sure you have `nix` installed or install it with:

    ~~~~ shell
    sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
    ~~~~
 -  Do `nix run`, which will fetch the OpenAPI spec, generate the rust types and
    format the resulting code.

[OpenResponses]: https://github.com/openresponses/openresponses
[oas3-gen]: https://github.com/eklipse2k8/oas3-gen
