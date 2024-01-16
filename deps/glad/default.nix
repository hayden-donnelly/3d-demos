{
    stdenv,
    ...
}:
stdenv.mkDerivation {
    pname = "glad";
    version = "v2.0.4";
    src = ./src;
    buildPhase = ''
    '';
    installPhase = ''
        mkdir -p $dev/include
        cp -vr ../include/* $dev/include
    '';
}
