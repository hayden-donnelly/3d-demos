# 3d-demos
3D graphics demos with OpenGL.

## Development Environment
First clone the repo and cd into it.
```
git clone https://github.com/hayden-donnelly/3d-demos.git
```
```
cd 3d-demos
```

Then create a development shell with Nix.
```
nix develop
```

Finally, build the local dependencies:
```
bash scripts/build_deps.sh
```

## Running Demos
Demos can be built and run by calling their corresponding shell script.
For example, ``bash scripts/sdf1.sh`` will build and run ``sdf1``.
