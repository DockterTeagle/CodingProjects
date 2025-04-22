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
    gitleaks
    commitlint
    bash-language-server
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
      stdenv = pkgs.libcxxStdenv;
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
          neocmakelsp
          cmake-format
          #end cmake
          #begin c tools
          clang-tools
          valgrind
          cppcheck
          cpplint
          doxygen
          gtest
          lcov
          libclang
          vcpkg
          vcpkg-tool
          gdb
        ]
        ++ commonPackages;
      enterShell =
        #bash
        ''
          export CODELLDB_PATH=${inputs'.rustacean.packages.codelldb}/bin/codelldb
        '';
    };
    zigShell = {
      stdenv = pkgs.zigStdenv;
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
      packages = with pkgs;
        [
          inputs'.rustacean.packages.codelldb
          graphviz
          rust-analyzer
        ]
        ++ commonPackages;
    };
  };
}
