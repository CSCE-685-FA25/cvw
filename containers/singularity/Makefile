# This Makefile contains recipes for managing Singularity containers and running regression tests.
CVW_GIT?="https://github.com/CSCE-685-FA25/cvw"
CVW_MOUNT?=$(pwd)/../../
USERNAME=cad
QUESTA_HOME?=/opt/coe/mentorgraphics/modelsim-2021.3
VCS_HOME?=/opt/coe/synopsys/vcs

# commandline: Opens an interactive shell inside the Singularity container with mounted directories.
commandline:
	@if [ -d "$(QUESTA_HOME)" ] && [ -d "$(VCS_HOME)" ]; then \
		singularity exec \
		--bind ${CVW_MOUNT}:/home/cad/cvw \
		--bind $(QUESTA_HOME):/cad/mentor/questa_sim-xxxx.x_x \
		--bind ${VCS_HOME}:/cad/synopsys/VCS \
		apptainers/toolchains_wally_latest.sif /bin/bash; \
	else \
		echo "Launching without Questa or VCS support..."; \
		echo "[Warning] Consider 'load-research'"; \
		singularity exec \
		--bind ${CVW_MOUNT}:/home/cad/cvw \
		apptainers/toolchains_wally_latest.sif /bin/bash; \
	fi

# regression_openhw_cvw: Runs regression tests inside the Singularity container with mounted directories.
regression_openhw_cvw:
	@if [ -d "$(QUESTA_HOME)" ] && [ -d "$(VCS_HOME)" ]; then \
		singularity exec \
		--bind ${CVW_MOUNT}:/home/cad/cvw \
		--bind $(QUESTA_HOME):/cad/mentor/questa_sim-xxxx.x_x \
		--bind ${VCS_HOME}:/cad/synopsys/VCS \
		apptainers/regression_wally_latest.sif; \
	else
		echo "Launching without Questa or VCS support..."; \
		echo "[Warning] Consider 'load-research'"; \
		singularity exec \
		--bind ${CVW_MOUNT}:/home/cad/cvw \
		apptainers/regression_wally_latest.sif; \
	fi

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
