{
  lib,
  stdenv,
  sources,
  nodejs_24,
  pnpm_11,
  fetchPnpmDeps,
  pnpmConfigHook,
  makeWrapper,
  python3,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "nexus-media-web";
  inherit (sources.nexus-media-web) version src;

  pnpmDeps = fetchPnpmDeps {
    pname = "nexus-media-web-pnpm-deps";
    inherit (finalAttrs) version src;
    pnpm = pnpm_11;
    fetcherVersion = 4;
    pnpmInstallFlags = [ "--registry=https://registry.npmmirror.com" ];
    prePnpmInstall = ''
      echo 'registry=https://registry.npmmirror.com' >> .npmrc
      if [ -n "''${https_proxy:-}" ]; then
        PROXY=$(printf '%s' "$https_proxy" | sed 's|^socks5://|socks5h://|')
        echo "proxy=$PROXY" >> .npmrc
        echo "https-proxy=$PROXY" >> .npmrc
      fi
    '';
    hash = lib.fakeHash;
  };

  nativeBuildInputs = [
    nodejs_24
    pnpmConfigHook
    pnpm_11
    makeWrapper
    python3
  ];

  env.CI = "true";
  env.NODE_OPTIONS = "--max-old-space-size=4096";

  preBuild = ''
    pnpm -r run stub --if-present
  '';

  buildPhase = ''
    runHook preBuild
    pnpm run build:nexus
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp -r apps/nexus-media/dist/. $out/
    makeWrapper ${python3.interpreter} $out/bin/nexus-media-web \
      --add-flags "-m" \
      --add-flags "http.server" \
      --add-flags "''${PORT:-8080}" \
      --add-flags "--directory" \
      --add-flags "$out"
    runHook postInstall
  '';

  meta = {
    description = "Vue 3 web frontend for the Nexus Media media library manager";
    homepage = "https://github.com/linyuan0213/nexus-media-web";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = [
      {
        github = "zhyiheihei";
        name = "zhyiheihei";
      }
    ];
    mainProgram = "nexus-media-web";
  };
})
