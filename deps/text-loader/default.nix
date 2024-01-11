{
    stdenv,
    ...
}:
stdenv.mkDerivation {
    pname = "text-loader";
    version = "v0.0.0";
    src = ./src;
    buildPhase = ''
    '';
    installPhase = ''
        mkdir -p $dev/include
        cp -vr ../include/* $dev/include
    '';
}
