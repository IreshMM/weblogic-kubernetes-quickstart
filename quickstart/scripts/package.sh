#!/bin/bash

SCRIPT_PATH="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd )"

# Package the application
jar cvf /tmp/archive.zip -C ${SCRIPT_PATH}/.. wlsdeploy


PACKAGE_CMD="${SCRIPT_PATH}/../tools/imagetool/bin/imagetool.sh \
    createAuxImage \
    --tag docker.io/ireshmm/wls-quickstart:1.0 \
    --wdtModel ${SCRIPT_PATH}/../model.yaml \
    --wdtVariables ${SCRIPT_PATH}/../variables.properties \
    --wdtArchive /tmp/archive.zip"
    
echo $PACKAGE_CMD