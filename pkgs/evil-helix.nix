{
  stdenv,
  fetchzip,
  lib,
  libgcc,
  nix-update-script,
  autoPatchelfHook,
}:

stdenv.mkDerivation rec {
  name = "evil-helix";
  version = "20250413";

  # This release tarball includes source code for the tree-sitter grammars,
  # which is not ordinarily part of the repository.
  src = fetchzip {
    url = "https://github.com/usagi-flow/evil-helix/releases/download/release-${version}/evil-helix-amd64-linux.tar.gz";
    hash = "sha256-1hJLMgtJU7kNOjB2A6PhAkwM7Cxn4ckD/Ou2o5Hf/t0=";
    #stripRoot = false;
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [ libgcc stdenv.cc.cc.lib];

  # sourceRoot = ".";

  env.HELIX_DEFAULT_RUNTIME = "${placeholder "out"}/lib/runtime";

  
  installPhase = ''
    runHook preInstall
    install -m755 -D hx $out/bin/hx
    runHook postInstall
  '';



  postInstall = ''
    mkdir -p $out/lib
    cp -r runtime $out/lib
  '';

  doInstallCheck = true;

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    description = "Post-modern modal text editor";
    homepage = "https://helix-editor.com";
    changelog = "https://github.com/helix-editor/helix/blob/${version}/CHANGELOG.md";
    license = lib.licenses.mpl20;
    mainProgram = "hx";
    maintainers = with lib.maintainers; [
      danth
      yusdacra
      zowoq
    ];
  };
}
