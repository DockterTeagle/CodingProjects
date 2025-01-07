{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    # dream2nix.url = "github:nix-community/dream2nix";
    nixd.url = "github:nix-community/nixd";
    rustacean.url = "github:mrcjkb/rustaceanvim";
  };
  outputs =
    inputs@{
      self,
      flake-parts,
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
          formatter = pkgs.nixfmt-rfc-style;
          checks = {
            pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                nixfmt-rfc-style.enable = true;
                rustfmt.enable = true;
                cargo-check.enable = true;
                clippy.enable = true;
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
                inputs'.rustacean.packages.codelldb
                graphviz
                cargo
                rustc # needed?
                rust-analyzer
                rustfmt
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
