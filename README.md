# EasyBuild setup (venv + pip) for ParaView/VisIt with ANARI on VISTA (GH200, aarch64)

This repository contains a set of EasyBuild recipes (`*.eb`) to compile ParaView+ANARI and VisIt+ANARI and their dependencies for the VISTA supercomputer (NVIDIA GH200, aarch64) using the `foss/2024a` toolchain.

The install is non-root and isolated under a directory you control.

## What is EasyBuild (very short)

[**EasyBuild**](https://easybuild.io/) automates building HPC software stacks with consistent prefixes, modules, and dependencies. You provide an "easyconfig" (`.eb`) file; EasyBuild builds, installs, and generates a module for you. Use `--robot` to auto-resolve dependencies from local `.eb` files.

## Quick start (copy/paste)

```bash
#!/bin/bash
# choose your working area
cd ~/scratch/easybuild

# install prefix and module path
export EASYBUILD_PREFIX="$PWD/easybuild"
export MODULEPATH="$EASYBUILD_PREFIX/modules/all:$MODULEPATH"

# create & activate a Python venv (one time only)
# python3 -m venv "$PWD/venvs/eb"
source "$PWD/venvs/eb/bin/activate"

# upgrade pip and install EasyBuild (one time only)
# pip install --upgrade pip
# pip install easybuild

# optional: show version
eb --version
```

If you start a new shell, re-export `EASYBUILD_PREFIX`/`MODULEPATH` and source the venv again.

## Directory layout

Place this repo (the folder with the `.eb` files) anywhere, e.g.

```
~/scratch/easybuild/vista_easybuild/
```

We will point `--robot` to this directory so EasyBuild can find all recipes locally.

## Build the stacks

### 1) ParaView + ANARI

```bash
cd ~/scratch/easybuild/vista_easybuild

# Build with automatic dependency resolution from current folder
eb ParaView-ANARI-iw-6.0.1-foss-2024a.eb \
   --robot=$PWD \
   --rebuild \
   --job 8 \
   --skip-test  # see Perl note below
```

### 2) VisIt + ANARI

```bash
eb Visit-ANARI-mj-3.5.0-foss-2024a.eb \
   --robot=$PWD \
   --rebuild \
   --job 8 \
   --skip-test  # see Perl note below
```

### Why `--skip-test`?

The `Perl` and `Perl-bundle-CPAN` easyconfigs in this set fail their test phases on this platform. The builds themselves are fine, but the test targets exit non-zero. Use `--skip-test` to avoid stopping the full dependency graph.

## After a successful build

Load modules like:

```bash
module use $EASYBUILD_PREFIX/modules/all
module avail
module load ParaView-ANARI-iw/6.0.1-foss-2024a
# or
module load Visit-ANARI-mj/3.5.0-foss-2024a
```

## What these easyconfigs include

### Core toolchain & languages:

- `GCCcore-13.3.0.eb` – base compiler core for `foss/2024a`
- `Python-3.11.5-GCCcore-13.3.0.eb` – Python runtime used by ParaView/VisIt tooling
- `CUDA-12.8.0.eb` – CUDA toolkit (for GH200 builds needing CUDA features)

### Math/GUI/system libs:

- `GLFW-3.4-GCCcore-13.3.0.eb`, `Qwt-6.3.0-GCCcore-13.3.0.eb`, `Tcl-8.6.14-GCCcore-13.3.0.eb`
- `OpenColorIO-2.4.2-GCC-13.3.0.eb`
- `VTK-9.5.0-foss-2024a.eb` (ParaView/VisIt dependency)

### Rendering stack for ANARI/OSPRay:

- `ANARI-SDK-0.15.0-foss-2024a.eb`
- `OSPRay-3.2.0.eb` (+ an alternative `OSPRay-3.2.0-foss-2024a.eb` if needed)
- `embree-4.4.0-GCCcore-13.3.0.eb`, `ispc-1.27.0-GCCcore-13.3.0.eb`
- `rkcommon-1.14.2-GCCcore-13.3.0.eb`

### Utilities:

- `minizip-ng-4.0.10-GCC-13.3.0.eb`, `pystring-1.1.4-...eb` (+ header-files patch)
- `Perl-5.38.2-GCCcore-13.3.0.eb`, `Perl-bundle-CPAN-5.38.2-GCCcore-13.3.0.eb` (require `--skip-test`)

### Applications:

- `ParaView-5.13.2-foss-2024a.eb`, `ParaView-6.0.1-foss-2024a.eb`
- `ParaView-ANARI-iw-6.0.1-foss-2024a.eb` (ParaView with ANARI plugins/integration)
- `Visit-ANARI-mj-3.5.0-foss-2024a.eb` (VisIt with ANARI)
- `ParaView-ANARI-sz-5.12.0-foss-2024a.eb` (alt build recipe)

Use `--robot=$PWD` so that dependencies are picked from this folder first.

## Notes specific to VISTA (GH200, aarch64)

- These recipes are tuned for **aarch64** nodes with **NVIDIA GH200**.
- **CUDA 12.8** is provided as an easyconfig to ensure builds find a consistent toolkit.
- If the site has global modules you prefer, you may load the site's `foss/2024a` first and let EasyBuild reuse/align with it. Otherwise, the local tree is self-contained.

## Common options you may want

- `--dry-run` – show what would be built and where
- `--job N` – parallel build (per package)
- `--robot-paths=$PWD:/extra/eb/roots` – add more search roots
- `--from-pr` / `--try-toolchain` – advanced debugging
- `--force` – rebuild even if a module exists (use with care)

## Troubleshooting

- **Perl test failures** → build with `--skip-test` (known on this platform).
- **Missing modules after build** → ensure `module use $EASYBUILD_PREFIX/modules/all` in your shell/profile.
- **CMakeLists not found** → some projects keep sources under `src/`; the `.eb` files already set correct `sources`/`start_dir`. Build via the provided recipes rather than calling CMake manually.
- **Linking to CUDA/OSPRay/Embree** → keep consistent toolchain (`foss/2024a`) across all dependencies; let `--robot` resolve from this repo.

## Example: fresh login sequence

```bash
cd ~/scratch/easybuild
export EASYBUILD_PREFIX="$PWD/easybuild"
export MODULEPATH="$EASYBUILD_PREFIX/modules/all:$MODULEPATH"
source "$PWD/venvs/eb/bin/activate"
module use $EASYBUILD_PREFIX/modules/all
module avail
```
