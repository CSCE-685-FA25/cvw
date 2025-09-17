#!/bin/bash

CVW_GIT=${CVW_GIT}

if [ -z "${CVW_GIT}" ]; then
    export CVW_GIT="https://github.com/openhwgroup/cvw"
    echo "No CVW_GIT is provided, using: ${CVW_GIT}"
else
    export CVW_GIT="https://github.com/CSCE-685-FA25/cvw"
    echo "Using customized CVW_GIT: ${CVW_GIT}"
fi

if [[ ! -f "/home/${USER}/cvw/setup.sh" ]] || [[ "${CLEAN_CVW}" -eq 1 ]]; then
    cd /home/${USER} && rm -rf /home/${USER}/cvw
    git clone --recurse-submodules ${CVW_GIT} ${CVW_MOUNT}
fi

singularity exec --bind /opt/coe/mentorgraphics:/opt/coe/mentorgraphics apptainers/toolchains_wally_latest.sif bash -c "cd /home/${USER}/cvw && ./setup.sh && ./site-setup.sh"
