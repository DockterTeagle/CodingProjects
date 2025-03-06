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
    markdownlint-cli
    markdownlint-cli2
    commitizen
    convco
    mdsh
    gitleaks
  ];
  hooks = {
    deadnix.enable = true;
    markdownlint.enable = true;
    mdsh.enable = true;
    flake-checker.enable = true;
    check-merge-conflicts.enable = true;
    commitizen.enable = true;
    # trufflehog.enable = true;
    convco.enable = true;
    forbid-new-submodules.enable = true;
    gitleaks = {
      name = "gitleaks";
      enable = true;
      entry = "gitleaks dir";
    };
    # clang-tidy.enable = true;
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
