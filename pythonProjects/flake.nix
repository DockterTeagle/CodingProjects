{
  description = "Python Projects Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs@ { self, nixpkgs, flake-parts, rustacean, ... }:
    flake-parts.lib.mkFlake { inherit inputs; }
      {
        systems = [
          "x86_64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ];
        perSystem =
          { config
          , self'
          , inputs'
          , pkgs
          , system
          , ...
          }:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            devShells.default = pkgs.mkShell
              {
                buildInputs = with pkgs;[
                  zsh
                  python312Full
                  python312Packages.numpy_2
                  python312Packages.scipy
                  python312Packages.sympy
                  python312Packages.seaborn
                  python312Packages.matplotlib
                  python312Packages.pandas
                  python312Packages.pandas-stubs
                  python312Packages.openpyxl
                  python312Packages.black
                  python312Packages.debugpy
                  python312Packages.mypy
                  pyright
                  ruff-lsp
                  ruff
                ];
              };
          };
      };
}
