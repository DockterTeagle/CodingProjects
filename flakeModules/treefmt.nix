{inputs', ...}: {
  settings = {
    global = {
      excludes = ["**/build/**"];
    };
  };
  flakeFormatter = true;
  programs = {
    deadnix.enable = true;
    # clang-format.enable = true;
    cmake-format.enable = true;
    alejandra = {
      enable = true;
      package = inputs'.alejandra.packages.default;
    };
    statix = {
      enable = true;
    };
    rustfmt.enable = true;
  };
}
