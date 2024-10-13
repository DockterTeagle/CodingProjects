{
  description = "rustacean flake";
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rustacean.url = "github:mrcjkb/rustaceanvim";
  };
  outputs = { nixpkgs, rustacean, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell
        {
          buildInputs = with pkgs;[
            llvm
            rocmPackages.llvm.clang-tools-extra
            libcxx
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

}
