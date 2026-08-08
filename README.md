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
| `filecodebox` | [filecodebox](https://github.com/vastsa/FileCodeBox) | 2.5.4 | Lightweight anonymous file sharing server with a FastAPI backend and Vue 3 theme |
| `moviepilot` | [moviepilot](https://github.com/jxxghp/MoviePilot) | 2.15.5 | Media automation platform for downloads, organization, scraping and notifications |
| `nexus-media` | [nexus-media](https://github.com/linyuan0213/nexus-media) | 4.4.5 | Media library manager with automated downloading, media organization and subscription workflows |
| `nexus-media-web` | [nexus-media-web](https://github.com/linyuan0213/nexus-media-web) | latest | Vue 3 web frontend for the Nexus Media media library manager |
| `sun-panel` | [sun-panel](https://github.com/hslr-s/sun-panel) | 1.3.0 | Server and NAS navigation panel, homepage, browser homepage |
| `docker-proxy` | [docker-proxy](https://github.com/dqzboy/Docker-Proxy) | 5.1.3 | Self-hosted Docker registry proxy with host-based upstream routing |
| `docker-proxy-hubcmdui` | [Docker-Proxy](https://github.com/dqzboy/Docker-Proxy) | 5.1.3 | Web management panel for the Docker-Proxy registry proxy |
| `vertex` | [vertex](https://github.com/vertex-center/vertex) | 0.17.0 | Self-hosted lab manager for one-click container service installation |

## Development

`nix run .#update` refreshes `_sources` from `nvfetcher.toml`, regenerates the
README from `pkgs/_meta/readme`, and runs per-package update scripts.
