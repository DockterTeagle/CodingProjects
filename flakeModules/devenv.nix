{
  pkgs,
  inputs',
  treefmt,
  self',
  lib,
  ...
}: {
  shells = {
    default = {
      packages = [
        inputs'.nixd.packages.nixd
        inputs'.alejandra.packages.default
        inputs'.statix.packages.default
        treefmt.build.wrapper
      ];
      git-hooks = import ./hooks.nix {inherit self' treefmt inputs' pkgs lib;};
    };
    cppShell = {
      languages.cplusplus.enable = true;
      cachix = {
        enable = true;
      };
      packages = with pkgs; [
        inputs'.nixd.packages.nixd
        alejandra
        statix
        treefmt.build.wrapper
        inputs'.rustacean.packages.codelldb
        inputs'.nixd.packages.nixd
        marksman
        #cmake
        cmake
        cmake-lint
        cmake-language-server
        cmake-format
        #end cmake
        #begin c tools
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
        # vcpkg
        # vcpkg-tool
      ];
    };
    # create devShells.default
  };
}
# devShells = {
#   default = pkgs.mkShell {
#     packages = [
#       inputs'.nixd.packages.nixd
#     ];
#   };
#   zigShell = pkgs.mkShell {
#     packages = with pkgs; [
#       zigpkgs.master
#       zls
#       inputs'.rustacean.packages.codelldb
#       inputs'.nixd.packages.nixd
#     ];
#   };
#   rustShell = pkgs.mkShell {
#     packages = with pkgs; [
#       self'.checks.pre-commit-check.enabledPackages
#       inputs'.nixd.packages.nixd
#       inputs'.rustacean.packages.codelldb
#       (fenix.complete.withComponents [
#         "cargo"
#         "clippy"
#         "rust-src"
#         "rustc"
#         "rustfmt"
#       ])
#       graphviz
#       rust-analyzer-nightly
#       ltex-ls-plus
#       marksman
#     ];
#     inherit (self'.checks.pre-commit-check) shellHook;
#   };
#
#   cppShell = pkgs.mkShell {
#     stdenv = pkgs.clangdStdenv;
#     shellHook = # bash
#       ''
#         ${self'.checks.pre-commit-check.shellHook}
#         export CPLUS_INCLUDE_PATH=$(pwd)/include/
#         export LIBCXX_INCLUDE_PATH=${pkgs.libcxx.dev}/include/c++/v1
#         export LIBCXX_LIB_PATH=${pkgs.libcxx.out}/lib
#         export CC=${pkgs.clang}/bin/clang
#         export CXX=${pkgs.clang}/bin/clang++
#         export CXXFLAGS="-stdlib=libc++ -I${pkgs.libcxx}/include/c++/v1"
#         export LDFLAGS="-L${pkgs.libcxx}/lib -lc++ -lc++abi"
#         export CODELLDB_PATH=${inputs'.rustacean.packages.codelldb}/bin/codelldb
#         export MY_INCLUDE_PATH=$(pwd)/include
#       '';
#     packages = with pkgs; [
#       inputs'.rustacean.packages.codelldb
#       inputs'.nixd.packages.nixd
#       self'.checks.pre-commit-check.enabledPackages
#       marksman
#       #cmake
#       cmake
#       cmake-lint
#       cmake-language-server
#       cmake-format
#       #end cmake
#       #begin c tools
#       clang-tools
#       valgrind
#       libcxx
#       clang
#       codespell
#       cppcheck
#       cpplint
#       doxygen
#       gtest
#       lcov
#       # vcpkg
#       # vcpkg-tool
#     ];
#   };
# };

