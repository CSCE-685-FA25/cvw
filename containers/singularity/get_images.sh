#!/bin/bash

UBUNTU_BUILD=${UBUNTU_BUILD:-0}
TOOLCHAINS_BUILD=${TOOLCHAINS_BUILD:-0}

if [ $UBUNTU_BUILD -eq 1 ]; then
    singularity build --fakeroot apptainers/ubuntu_wally_latest.sif Singularity.ubuntu
else
    if [ ! -f apptainers/ubuntu_wally_latest.sif ]; then
        singularity pull apptainers/ubuntu_wally_latest.sif docker://wallysoc/ubuntu_wally:latest
    fi
fi

if [ $TOOLCHAINS_BUILD -eq 1 ]; then
    python3 get_buildroot_testvector.py
    singularity build --fakeroot apptainers/toolchains_wally_latest.sif Singularity.builds
else
    if [ ! -f apptainers/toolchains_wally_latest.sif ]; then
        singularity pull apptainers/toolchains_wally_latest.sif docker://wallysoc/toolchains_wally:latest
    fi
fi
