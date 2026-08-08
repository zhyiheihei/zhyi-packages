# zhyiheihei's NUR Packages

![Build and populate cache](https://github.com/zhyiheihei/zhyi-packages/workflows/Build%20and%20populate%20cache/badge.svg)

Personal NUR repository, structured after
[xddxdd/nur-packages](https://github.com/xddxdd/nur-packages).

## How to use

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zhyi-packages = {
      url = "github:zhyiheihei/zhyi-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.zhyi-packages.nixosModules.setupOverlay
      ];
    };
  };
}
```

## Packages

| Path | Name | Version | Description |
| ---- | ---- | ------- | ----------- |
| `vaults3` | [vaults3](https://github.com/Kodiqa-Solutions/VaultS3) | 4.4.50 | Lightweight S3-compatible object storage with built-in web dashboard |

## Development

`nix run .#update` refreshes `_sources` from `nvfetcher.toml`, regenerates the
README from `pkgs/_meta/readme`, and runs per-package update scripts.
