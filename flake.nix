{
  description = "rustacean flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rustacean.url = "github:mrcjkb/rustaceanvim";
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
                  libcxx
                  gnumake
                  cmake
                  rocmPackages_6.llvm.clang
                  clang-tools
                  #rust
                  rustacean.packages.${system}.codelldb
                  cargo
                  rustc
                  rust-analyzer
                  rustfmt
                ];
                shellHook = ''
                  export SHELL=$(which zsh)
                  if [ -z "$ZSH_VERSION" ]; then
                    exec zsh
                  fi
                '';
              };
          };

      };
}
