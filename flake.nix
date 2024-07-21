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
            cargo
            rustc
            rustup
            rustfmt
            rust-analyzer
            libgcc
            glib
            gtk2
            gcc-unwrapped
            llvm_18
            pkg-config
            clang-tools
            rustacean.packages.${system}.rustaceanvim
            rustacean.packages.${system}.codelldb
          ];
          shellHook = ''
            ech
            export PATH="$PATH:${rustacean.packages.${system}.codelldb}/bin"
            export PATH="$PATH:${rustacean.packages.${system}.rustaceanvim}/bin"
            export PATH="${pkgs.rust-analyzer}/bin:$PATH"
          '';
        };
    };
}
