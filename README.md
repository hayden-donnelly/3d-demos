# 3d-demos
3D graphics demos with OpenGL.

## Building and Running
To build, use:
```
make all
```

To build and run, use:
```
make run
```

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
