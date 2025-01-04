{
  description = "cpp projects flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixd.url = "github:nix-community/nixd";
    rustacean.url = "github:mrcjkb/rustaceanvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
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
              stdenv = pkgs.clandStdenv;
              shellHook = # bash
                ''
                  export LIBCXX_INCLUDE_PATH=${pkgs.libcxx.dev}/include/c++/v1
                  export LIBCXX_LIB_PATH=${pkgs.libcxx.out}/lib
                  export CODELLDB_PATH=${inputs'.rustacean.packages.codelldb}
                  export CC=${pkgs.clang}/bin/clang
                  export CXX=${pkgs.clang}/bin/clang++
                  export CXXFLAGS="-stdlib=libc++ -I${pkgs.libcxx}/include/c++/v1"
                  export LDFLAGS="-L${pkgs.libcxx}/lib -lc++ -lc++abi"
                  export CODELLDB_PATH=${inputs'.rustacean.packages.codelldb}/bin/codelldb
                '';
              packages = with pkgs; [
                inputs'.rustacean.packages.codelldb
                # inputs'.nixd.packages.nixd
                valgrind
                libcxx
                cmake
                cmake-lint
                cmake-language-server
                cmake-format
                clang-tools
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
