{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    nixd.url = "github:nix-community/nixd";
    rustacean.url = "github:mrcjkb/rustaceanvim";
    devenv.url = "github:cachix/devenv";
    alejandra.url = "github:kamadorueda/alejandra";
    statix.url = "github:oppiliappan/statix";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zig-overlay.url = "github:mitchellh/zig-overlay";
  };
  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      imports = with inputs; [
        devenv.flakeModule
        treefmt-nix.flakeModule
      ];
      perSystem = {
        self',
        inputs',
        pkgs,
        system,
        config,
        lib,
        ...
      }: {
        _module.args.pkgs = import nixpkgs {
          inherit system;
          overlays = with inputs; [
            fenix.overlays.default
            zig-overlay.overlays.default
          ];
        };
        devenv = import ./flakeModules/devenv-shells.nix {
          inherit self' inputs' pkgs system lib;
          inherit (config) treefmt;
        };
        treefmt = import ./flakeModules/treefmt.nix {inherit self' inputs' pkgs system lib;};
      };
    };
}
