{
  config,
  pkgs,
  system,
  ...
}@args:

{
  projectRootFile = "flake.nix";
  programs.nixfmt.enable = true;
  programs.prettier.enable = true;
  settings.global.excludes = [
    ".direnv/**"
    ".envrc"
  ];
}
