{
    description = "3D graphics demos with OpenGL.";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/23.11";
        flake-utils.url = "github:numtide/flake-utils";
        nixgl = {
            url = "github:guibou/nixgl";
            inputs = {
                nixpkgs.follows = "nixpkgs";
                flake-utils.follows = "flake-utils";
            };
        };
    };
    outputs = inputs@{ self, nixpkgs, flake-utils, ... }: 
        flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system: 
        let
            inherit (nixpkgs) lib;

            pkgs = import nixpkgs { 
                inherit system; 
                overlays = [
                    inputs.nixgl.overlays.default
                ]; 
            };
        in {
            devShells = {
                default = pkgs.mkShell rec {
                    name = "opengl-x11";
                    buildInputs = with pkgs; [
                        libxkbcommon
                        xorg.libX11
                        xorg.libXrandr
                        xorg.libXinerama
                        xorg.libXcursor
                        xorg.libXi
                        xorg.libXext
                        gcc
                        cmake
                        gnumake
                    ];
                    shellHook = ''
                        source <(sed -Ee '/\$@/d' ${lib.getExe pkgs.nixgl.nixGLIntel})
                        source <(sed -Ee '/\$@/d' ${lib.getExe pkgs.nixgl.auto.nixGLNvidia}*)
                    '';
                };
            };
        }
    );
}
