{
  description = "zhyi-packages: personal Nix package library";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: builtins.listToAttrs (map (system: {
        name = system;
        value = f system;
      }) systems);
      sourcesFor = pkgs: import ./helpers/_sources/generated.nix {
        inherit (pkgs) fetchurl fetchgit fetchFromGitHub dockerTools;
      };
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        rec {
          vaults3 = pkgs.callPackage ./pkgs/vaults3 {
            sources = sourcesFor pkgs;
          };
          default = vaults3;
        }
      );

      overlays.default = final: prev: {
        vaults3 = final.callPackage ./pkgs/vaults3 {
          sources = sourcesFor final;
        };
      };

      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          vaults3 = pkgs.runCommand "vaults3-check" { } ''
            ${pkgs.coreutils}/bin/test -x ${self.packages.${system}.vaults3}/bin/vaults3
            ${pkgs.coreutils}/bin/test -x ${self.packages.${system}.vaults3}/bin/vaults3-cli
            mkdir -p $out
          '';
        }
      );
    };
}

