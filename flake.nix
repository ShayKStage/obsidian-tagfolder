{
  description = "For intellisense in random files";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default-linux";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    {
      self,
      nixpkgs,
      flake-parts,
      systems,
      treefmt-nix,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        treefmt-nix.flakeModule
      ];

      systems = import systems;

      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }@args:
        {
          treefmt = import ./treefmt.nix;

          devShells.default =
            pkgs.mkShell {
              name = "obsidian-tagfolder-shell";
              venvDir = "./.venv";
              packages = with pkgs; [
                nixfmt-rfc-style
                config.treefmt.build.wrapper
                nodejs
                nodePackages.typescript
                nodePackages.typescript-language-server
                nodePackages.ts-node
              ];
            };
        };
    };
}
