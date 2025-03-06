{
  pkgs,
  inputs',
  treefmt,
  self',
  lib,
  ...
}: let
  commonPackages = with pkgs; [
    inputs'.nixd.packages.nixd
    inputs'.alejandra.packages.default
    inputs'.statix.packages.default
    treefmt.build.wrapper
    ltex-ls-plus
    marksman
    codespell
  ];
in {
  shells = {
    default = {
      cachix = {
        enable = true;
        pull = ["pre-commit-hooks"];
      };
      packages = commonPackages;
      git-hooks = import ./hooks.nix {inherit self' treefmt inputs' pkgs lib;};
    };
    cppShell = {
      languages.cplusplus.enable = true;
      cachix = {
        enable = true;
      };
      packages = with pkgs;
        [
          inputs'.rustacean.packages.codelldb
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
        ]
        ++ commonPackages;
    };
    zigShell = {
      languages.zig = {
        enable = true;
        package = pkgs.zigpkgs.master;
      };
      packages = with pkgs; [zls] ++ commonPackages;
    };
    rustShell = {
      git-hooks = import ./hooks.nix {inherit self' treefmt inputs' pkgs lib;};
      languages.rust = {
        enable = true;
        channel = "nightly";
      };
      packages = with pkgs; [
        inputs'.nixd.packages.nixd
        inputs'.rustacean.packages.codelldb
        graphviz
        rust-analyzer
        ltex-ls-plus
      ];
    };
  };
}
