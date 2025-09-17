# This Makefile contains recipes for managing Singularity containers and running regression tests.
CVW_GIT?="https://github.com/CSCE-685-FA25/cvw"
CVW_MOUNT?=$(pwd)/../../
USERNAME=cad
QUESTA_HOME?=/opt/coe/mentorgraphics/modelsim-2021.3/modeltech
VCS_HOME?=/opt/coe/synopsys/vcs/W-2024.09-SP2-4

# commandline: Opens an interactive shell inside the Singularity container with mounted directories.
commandline:
	singularity exec \
	--bind ${CVW_MOUNT}:/home/cad/cvw \
	--bind $(QUESTA_HOME):/cad/mentor/questa_sim-xxxx.x_x \
	--bind ${VCS_HOME}:/cad/synopsys/VCS \
	apptainers/toolchains_wally_latest.sif /bin/bash

# regression_openhw_cvw: Runs regression tests inside the Singularity container with mounted directories.
regression_openhw_cvw:
	singularity exec \
    --bind ${CVW_MOUNT}:/home/cad/cvw \
	--bind $(QUESTA_HOME):/cad/mentor/questa_sim-xxxx.x_x \
	--bind ${VCS_HOME}:/cad/synopsys/VCS \
	apptainers/toolchains_wally_latest.sif 

# push_hub: Placeholder for pushing Singularity images to a registry.
push_hub:
	# Placeholder for pushing to a Singularity registry

# pull_ubuntu: 
pull_ubuntu:
	singularity pull apptainers/ubuntu_wally_latest.sif docker://wallysoc/ubuntu_wally:latest

# pull_toolchains:
pull_toolchains:
	singularity pull apptainers/toolchains_wally_latest.sif docker://wallysoc/toolchains_wally:latest

# pull_regression
pull_regression:
	singularity pull apptainers/regression_wally_latest.sif docker://wallysoc/regression_wally:latest

# update_ubuntu: Builds the Singularity image for the Ubuntu environment.
update_ubuntu:
	singularity build ubuntu_wally_latest.sif Singularity.ubuntu

# update_toolchains: Builds the Singularity image for the toolchains environment.
update_toolchains:
	singularity build toolchains_wally_latest.sif Singularity.builds

# update_regression: Builds the Singularity image for the regression environment.
update_regression:
	singularity build regression_wally_latest.sif Singularity.regression
