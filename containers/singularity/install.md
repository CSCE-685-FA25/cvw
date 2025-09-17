# Wally Toolchain Singularity Container

Installing RISC-V tools from source gives you maximum control, but has several disadvantages:

* Building the executables takes several hours.
* Linux is poorly standardized, and the build steps might not work on your version.
* The source files are constantly changing, and the versions you download might not be compatible with this textbook flow.

Singularity is a tool to run applications in a prepackaged container including all of the operating system support required. Wally offers a container image with the open-source tools pre-installed. Using the container solves the long build time for gcc and the fussy installation of sail. The container runs on any platform supporting Singularity, including Linux and HPC environments. It can access files outside the container, including local installation of CAD tools such as Questa, and a local clone of the core-v-wally repository.

## Singularity Installation

### On Ubuntu

For Ubuntu 20.04 or later, install Singularity using the following commands:

```bash
sudo apt update
sudo apt install -y singularity-container
```

### On RedHat / Rocky Linux

For RedHat-based distributions, install Singularity using:

```bash
sudo yum -y install singularity
```

### On Other Platforms

Refer to the official Singularity documentation for installation instructions: https://sylabs.io/singularity/

## Pulling the Wally Container

Once Singularity is installed, you can pull the Wally container image. Ensure you have access to the container registry hosting the image.

```bash
singularity pull library://wallysoc/wally-singularity:latest
```

## Running the Singularity Container

To activate the container with GUI support, first identify your display port in the `/tmp/.X11-unix` directory. For example, if your display is `:51`, use the following command:

```bash
singularity exec --bind /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=:51 \
    --bind /home/user:/home/user --bind /cad:/cad wally-singularity.sif bash
```

This command mounts your home directory and CAD tools directory to be visible from the container. Change these paths as necessary based on your local system configuration.

## Working with the Container

Singularity containers are self-contained, and any data created within your container is lost when you exit the container. Therefore, be sure to work in your mounted home directory (e.g., `/home/user`) to permanently save your work outside the container.

To have permission to write to your mounted home directory, you may need to adjust permissions or use the `--fakeroot` option when running the container.

## Cleaning up a Singularity Container

The Singularity container image is large, so users may need to clean up a container when they aren’t using it anymore. To remove a Singularity image:

```bash
rm wally-singularity.sif
```

## Regenerating the Singularity Definition File

To create a custom Singularity image, you can use the provided definition files in the `singularity` folder. For example, to build the `Singularity.ubuntu` image:

```bash
singularity build ubuntu_wally_latest.sif Singularity.ubuntu
```

Modify the definition files as needed to include additional tools or configurations.

## Integrating Commercial CAD Tools

To integrate commercial CAD tools into your local Singularity container, ensure the tools are installed on your host system and mount the appropriate directories when running the container. For example:

```bash
singularity exec --bind /cad:/cad wally-singularity.sif bash
```
