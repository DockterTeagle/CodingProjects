{
  description = "rustacean flake";
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rustacean.url = "github:mrcjkb/rustaceanvim";
  };
  outputs = { self, nixpkgs, rustacean, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell
        {
          buildInputs = with pkgs;[
            clang
            libclang
            rocmPackages_6.llvm.clang-unwrapped
            libgcc
            glib
            gcc-unwrapped
            llvm_18
            pkg-config
            clang-tools
            rustacean.packages.${system}.codelldb
            rustc
            rustup
            rustfmt
            rust-analyzer
            cargo
          ];
          shellHook = ''
            rustup default stable
            rustup component add clippy
            export PATH="$HOME/.cargo/bin:$PATH"
            export PATH="$PATH:${rustacean.packages.${system}.codelldb}/bin"
            export PATH="${pkgs.rust-analyzer}/bin:$PATH"
            export PATH="$PATH:${pkgs.rustfmt}/bin"
          '';
        };
    };
}
