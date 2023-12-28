{
    stdenv,
    ar,
    ...
}:
stdenv.mkDerivation {
    pname = "glad";
    version = "v2.0.4";
    src = ./src;
    buildInputs = [ raylib ];
    buildPhase = ''
        gcc -c src/gl.c -o glad.o
        ar rcs libglad.a glad.o
    '';
    installPhase = ''
        mkdir -p $dev/include
        cp -vr ../include/* $dev/includes
        mkdir -p $out/lib $out
        cp -v libglad.a $out/lib/
    '';
}