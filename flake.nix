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
            pkgs = import nixpkgs { inherit system; };
        in {
            devShells = let
                overlays = [ inputs.nixgl.overlays.default self.overlays.default ];
            in {
                default = pkgs.mkShell {
                    name = "opengl";
                    buildInputs = with pkgs; [
                        gcc9
                        glfw
                    ];
                };
            };
        }
    );
}
