{inputs', ...}: {
  settings = {
    global = {
      excludes = ["**/build/**"];
    };
  };
  flakeFormatter = true;
  programs = {
    deadnix.enable = true;
    cmake-format.enable = true;
    alejandra = {
      enable = true;
      package = inputs'.alejandra.packages.default;
    };
    clang-format.enable = true;
    statix = {
      enable = true;
      # package = inputs'.statix.packages.default;
    };
    rustfmt.enable = true;
  };
}
