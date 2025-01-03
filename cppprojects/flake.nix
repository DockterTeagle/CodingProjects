{
  description = "cpp projects flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixd.url = "github:nix-community/nixd";
    rustacean.url = "github:mrcjkb/rustaceanvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
  };
  outputs =
    inputs@{
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
          inputs',
          pkgs,
          ...
        }:
        {
          devShells = {
            default = pkgs.mkShell {
              shellHook = # bash
                ''
                  export CODELLDB_PATH=${inputs'.rustacean.packages.codelldb}
                  export CC=${pkgs.clang}/bin/clang
                  export CXX=${pkgs.clang}/bin/clang++
                  export CXXFLAGS="-stdlib=libc++ -I${pkgs.libcxx.dev}/include/c++/v1"
                  export LDFLAGS="-L ${pkgs.libcxx.out}/lib -lc++ -lc++abi"
                '';
              packages = with pkgs; [
                inputs'.rustacean.packages.codelldb
                # inputs'.nixd.packages.nixd
                valgrind
                libcxx
                cmake
                clang
                clang-tools
                codespell
                cppcheck
                doxygen
                gtest
                lcov
              ];
            };
          };
        };
    };
}
