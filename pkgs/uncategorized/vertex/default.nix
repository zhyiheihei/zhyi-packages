{
  lib,
  stdenv,
  buildGoModule,
  nodejs,
  yarn-berry_4,
  sources,
}:
let
  inherit (sources.vertex) version src;

  web = stdenv.mkDerivation (finalWebAttrs: {
    pname = "vertex-web";
    inherit version src;

    missingHashes = ./missing-hashes.json;

    postPatch = ''
      printf 'approvedGitRepositories: ["**"]\nenableScripts: true\n' >> .yarnrc.yml
    '';

    offlineCache = yarn-berry_4.fetchYarnBerryDeps {
      inherit (finalWebAttrs) src;
      hash = "sha256-hg76Ol1wPnyBoJG9B2AX7/RQnqz+JMlEghUA9d2xuZ0=";
      missingHashes = ./missing-hashes.json;
    };

    nativeBuildInputs = [
      nodejs
      yarn-berry_4
      yarn-berry_4.yarnBerryConfigHook
    ];

    buildPhase = ''
      runHook preBuild
      yarn workspace @vertex-center/client build
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/vertex
      cp -r client/dist $out/share/vertex/web
      runHook postInstall
    '';
  });
in
buildGoModule (finalAttrs: {
  pname = "vertex";
  inherit version src;

  sourceRoot = "${finalAttrs.src.name}/server";

  vendorHash = "sha256-mfNCIyIGJF5+u5kZrJi+iXjoyao/0l5MfJFxT+Wz6Vs=";

  env.CGO_ENABLED = "0";
  env.GOPROXY = "https://goproxy.cn,direct";
  env.GOSUMDB = "sum.golang.google.cn";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=v${finalAttrs.version}"
  ];

  buildPhase = ''
    runHook preBuild
    mkdir -p $out/bin
    go build -ldflags="${toString finalAttrs.ldflags}" -o $out/bin/vertex ./cmd/main
    go build -ldflags="${toString finalAttrs.ldflags}" -o $out/bin/vertex-kernel ./cmd/kernel
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/vertex
    cp -r ${web}/share/vertex/web $out/share/vertex/
    runHook postInstall
  '';

  meta = {
    description = "Self-hosted lab manager for one-click container service installation";
    homepage = "https://github.com/vertex-center/vertex";
    changelog = "https://github.com/vertex-center/vertex/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = [
      {
        github = "zhyiheihei";
        name = "zhyiheihei";
      }
    ];
    mainProgram = "vertex";
  };
})
