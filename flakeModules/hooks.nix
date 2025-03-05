{
  pkgs,
  inputs',
  treefmt,
  ...
}: {
  enabledPackages = with pkgs; [
    deadnix
    clang-tools
    cmake-format
    cargo
    # clippy
    rustfmt
    treefmt.build.wrapper
  ];
  hooks = {
    alejandra = {
      enable = true;
      package = inputs'.alejandra.packages.default;
    };
    deadnix.enable = true;
    flake-checker.enable = true;
    # clang-format = {
    #   enable = true;
    #   types_or = lib.mkForce ["c" "c++"];
    # };
    # clang-tidy.enable = true;
    cmake-format.enable = true;
    # cargo-check.enable = true;
    # clippy.enable = true;
    # rustfmt.enable = true;
    treefmt = {
      enable = true;
      package = treefmt.build.wrapper;
    };
    statix = {
      enable = true;
      package = inputs'.statix.packages.default;
    };
  };
}
