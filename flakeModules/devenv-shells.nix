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
          cmake-language-server
          cmake-format
          #end cmake
          #begin c tools
          clang-tools
          valgrind
          conan
          cppcheck
          codespell
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
      tasks = {
        # "bash:hook" = {
        #   before = ["devenv:enterShell"];
        #   exec =
        #     #bash
        #     ''
        #       export CPLUS_INCLUDE_PATH=$(pwd)/include/
        #       export LIBCXX_INCLUDE_PATH=${pkgs.libcxx.dev}/include/c++/v1
        #       export LIBCXX_LIB_PATH=${pkgs.libcxx.out}/lib
        #       export CC=${pkgs.clang}/bin/clang
        #       export CXX=${pkgs.clang}/bin/clang++
        #       export CXXFLAGS="-stdlib=libc++ -I${pkgs.libcxx}/include/c++/v1"
        #       export CODELLDB_PATH=${inputs'.rustacean.packages.codelldb}/bin/codelldb
        #       export MY_INCLUDE_PATH=$(pwd)/include
        #     '';
        # };
      };
      #     shellHook = # bash
      # ''
      #   ${self'.checks.pre-commit-check.shellHook}
      # '';
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
