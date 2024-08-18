{
    description = "3D graphics demos with OpenGL.";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/24.05";
        flake-utils.url = "github:numtide/flake-utils";
        nixgl.url = "github:nix-community/nixGL";
    };
    outputs = inputs@{ self, nixpkgs, flake-utils, nixgl, ... }: 
        flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system: 
        let
            inherit (nixpkgs) lib;
            pkgs = import nixpkgs { 
                inherit system;
                overlays = [ nixgl.overlay ];
            };
        in {
            devShells.default = pkgs.mkShell {
                name = "3d-demos";
                buildInputs = with pkgs; [
                    gcc
                    cmake
                    libxkbcommon
                    xorg.libX11
                    xorg.libXi
                    xorg.libXcursor
                    xorg.libXext
                    xorg.libXinerama
                    xorg.libXrandr
                    xorg.libXrender
                ];
                shellHook = ''
                    source <(sed -Ee '/\$@/d' ${lib.getExe pkgs.nixgl.nixGLIntel})
                '';
                # source <(sed -Ee '/\$@/d' ${lib.getExe pkgs.nixgl.auto.nixGLNvidia}*)
            };
        }
    );
}
