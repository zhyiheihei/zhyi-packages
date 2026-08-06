# zhyi-packages

Personal Nix package library with `nvfetcher`-based semi-automatic updates.

## Packages

- `vaults3` (VaultS3 S3-compatible object storage), built from the official
  Linux release binaries for `x86_64-linux` and `aarch64-linux`.

## Update flow

`nvfetcher.toml` tracks upstream GitHub releases. A scheduled GitHub Actions
workflow refreshes `helpers/_sources` and opens an update PR; merge it, then:

```bash
nix flake update zhyi-packages
```

## Usage in another flake

```nix
inputs.zhyi-packages.url = "github:zhyiheihei/zhyi-packages";
```
