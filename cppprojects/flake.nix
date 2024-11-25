{
  description = "cpp projects flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rustacean.url = "github:mrcjkb/rustaceanvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
  };
  outputs =
    inputs@{
      flake-parts,
      rustacean,
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
                clang-format.enable = true;
                clang-tidy.enable = true;
              };
            };
          };
          devShells = {
            default = pkgs.mkShell {
              inherit (self'.checks.pre-commit-check) shellHook;
              buildInputs = with pkgs; [
                self'.checks.pre-commit-check.enabledPackages
                rustacean.packages.${system}.codelldb
                libcxx
                valgrind
                cmake
                rocmPackages.llvm.clang
                clang-tools
                codespell
                conan
                cppcheck
                doxygen
                gtest
                lcov
                vcpkg
                vcpkg-tool
              ];
            };
          };
        };
    };
}
