{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    # dream2nix.url = "github:nix-community/dream2nix";
    nixd.url = "github:nix-community/nixd";
    rustacean.url = "github:mrcjkb/rustaceanvim";
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          _module.args.pkgs = import nixpkgs {
            inherit system;
            overlays = [ inputs.fenix.overlays.default ];
          };
          formatter = pkgs.nixfmt-rfc-style;
          checks = {
            pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                nixfmt-rfc-style.enable = true;
                # rustfmt.enable = true;
                # cargo-check.enable = true;
                # clippy.enable = true;
                clang-format = {
                  enable = true;
                  types_or = nixpkgs.lib.mkForce [
                    "c"
                    "c++"
                  ];
                };
                clang-tidy = {
                  enable = true;
                  args = [
                    "--quiet"
                    "-p=build"
                  ];
                };
              };
            };
          };
          devShells = {
            rustShell = pkgs.mkShell {
              packages = with pkgs; [
                self'.checks.pre-commit-check.enabledPackages
                inputs'.nixd.packages.nixd
                inputs'.rustacean.packages.codelldb
                (fenix.complete.withComponents [
                  "cargo"
                  "clippy"
                  "rust-src"
                  "rustc"
                  "rustfmt"
                ])
                graphviz
                rust-analyzer-nightly
                ltex-ls-plus
              ];
              inherit (self'.checks.pre-commit-check) shellHook;
            };

            cppShell = pkgs.mkShell {
              stdenv = pkgs.clangdStdenv;
              shellHook = # bash
                ''
                  ${self'.checks.pre-commit-check.shellHook}
                  export CPLUS_INCLUDE_PATH=$(pwd)/include/
                  export LIBCXX_INCLUDE_PATH=${pkgs.libcxx.dev}/include/c++/v1
                  export LIBCXX_LIB_PATH=${pkgs.libcxx.out}/lib
                  export CC=${pkgs.clang}/bin/clang
                  export CXX=${pkgs.clang}/bin/clang++
                  export CXXFLAGS="-stdlib=libc++ -I${pkgs.libcxx}/include/c++/v1"
                  export LDFLAGS="-L${pkgs.libcxx}/lib -lc++ -lc++abi"
                  export CODELLDB_PATH=${inputs'.rustacean.packages.codelldb}/bin/codelldb
                  export MY_INCLUDE_PATH=$(pwd)/include
                '';
              packages = with pkgs; [
                inputs'.rustacean.packages.codelldb
                self'.checks.pre-commit-check.enabledPackages
                # inputs'.nixd.packages.nixd
                #cmake
                cmake
                cmake-lint
                cmake-language-server
                cmake-format
                clang-tools
                valgrind
                libcxx
                clang
                codespell
                cppcheck
                cpplint
                doxygen
                gtest
                lcov
                gdb
                vcpkg
                vcpkg-tool
              ];
            };
          };
        };
    };
}
