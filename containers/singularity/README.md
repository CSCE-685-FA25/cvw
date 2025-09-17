# Consistent Build of Toolchain for Wally

`Singularity.*` contains definitions for building Singularity images required for Wally's open-source features.

## Hazards

- If there is any change in `${CVW_HOME}/linux/buildroot-config-src` folder with main.config, you have to copy it to the current folder to `buildroot-config-src`
- If there is any change in `${CVW_HOME}/linux/testvector-generation` folder with main.config, you have to copy it to the current folder to `testvector-generation`

If you have any other questions, please read the [troubleshooting]() first.

## TL;DR

Steps:

1. Use `get_images.sh` to build the required images.
2. Run `start.sh` to start a containerized environment.

### Use of Start-up Script

Files in this folder can help you to build/fetch the environment you need to run Wally with the help of Singularity.

Here are some common use cases. It will **provide you an environment with RISC-V toolchains** required by this project:

```shell
# By default, we assume that you have cloned the cvw repository and are running the script at the relative path `docs/singularity`

# For HMC students, /opt/riscv is available and nothing needs to be built
TOOLCHAINS_MOUNT=/opt/riscv QUESTA=/cad/mentor/questa_sim-2023.4 ./start.sh

# For those with all the toolchains installed, simply mount the toolchains
TOOLCHAINS_MOUNT=<path-to-toolchains> ./start.sh

# For those who have nothing, fetching the builds is the easiest thing
CVW_MOUNT=<path-to-cvw> ./start.sh
```

For further usage, please consult the following configuration.

### Regression on Master Branch

The regression script is used by the image `wally-singularity` to run regressions on the master branch of a specific repository.

```shell
# create volume for permanent storage
singularity exec --bind cvw_temp:/home/cad/cvw \
    --bind /cad/mentor/questa_sim-2023.4:/cad/mentor/questa_sim-xxxx.x_x \
    wally-singularity.sif bash
```

## Scripts

There are four scripts:

- `start.sh` (most often used): Start running the container.
    - If you don't care about toolchains and running regression automatically, this script is the only thing you need to know.
- `get_images.sh`: Get Singularity image `wallysoc/ubuntu_wally` or `wallysoc/toolchains_wally`.
- `get_buildroot_testvector.py`: Copy buildroot and testvector configuration required for building.
- `run_regression.sh`: Run regressions with Verilator (and QuestaSIM) on specific CVW.
    - This script is not intended to be run directly, but inside the container.
    - However, it is a good resource to look into to know what is happening.
- `test.sh`: A test script to facilitate the above three.

All the following options in the corresponding scripts should be set by either:

- Define it right before the command: `USE_SINGULARITY=1 ./start.sh` with `USE_SINGULARITY` on the start-up script.
    - The variable is only effective for the current command, not the following environment.
- Declare it globally and use it any time afterwards:

```shell
# Declare it globally in the environment
export UBUNTU_BUILD=1

# Run the script with all the above variables
./get_images.sh
```

### Start-up Script: `start.sh`

There are two settings:

- Build/fetch both `ubuntu_wally` and toolchains in the Singularity image and use it.
- Build/fetch only `ubuntu_wally` and use the local toolchains folder.

Options:

- `UBUNTU_BUILD`:
    - Fetch by default.
    - Set `UBUNTU_BUILD=1` if you want to build with `Singularity.ubuntu`.
- `TOOLCHAINS_BUILD`:
    - Fetch by default.
    - Set `TOOLCHAINS_BUILD=1` if you want to build with `Singularity.build`.

### Image Building Script: `get_images.sh`

Options (if you want to build the images):

- `UBUNTU_BUILD`:
    - Fetch by default.
    - Set it to `1` if you want to build it instead of fetching it.
- `TOOLCHAINS_BUILD`:
    - Fetch by default.
    - Set it to `1` if you want to build it instead of fetching it.

### Regression Script: `run_regression.sh`

There are two parts for regression:

- Verilator: Must be able to run as it is open-sourced.
- Questa: OPTIONAL as it is a commercial EDA Tool.

There are three main knobs:

- `CLEAN_CVW`: Remove the `/home/${USERNAME}/cvw` inside the container (it can be a volume) and clone the `${CVW_GIT}`.
- `BUILD_RISCOF`: Build RISCOF in the `/home/${USERNAME}/cvw`. Sometimes you don't want to rebuild if there is no change in the test suite.
- `RUN_QUESTA`: Enable the QuestaSIM in regression.

Options:

- `CVW_GIT`: Git clone address.
- `CLEAN_CVW`: Clone `CVW_GIT` if enabled with `-e CLEAN_CVW=1`.
- `BUILD_RISCOF`: Rebuild RISCOF if enabled with `-e BUILD_RISCOF=1`.
- `RUN_QUESTA`: Run `vsim` to check if enabled with `-e RUN_QUESTA=1`.
    - `QUESTA`: Home folder for mounted QuestaSIM `/cad/mentor/questa_sim-xxxx.x_x` if enabled.
    - For example, if your `vsim` is in `/cad/mentor/questa_sim-2023.4/questasim/bin/vsim`, then your local QuestaSIM folder is `/cad/mentor/questa_sim-2023.4`. Add `-v /cad/mentor/questa_sim-2023.4:/cad/mentor/questa_sim-xxxx.x_x -e RUN_QUESTA=1`.
