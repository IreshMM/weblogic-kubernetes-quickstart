#!/bin/bash

SCRIPT_PATH="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd )"

# Package the application
jar cvf /tmp/archive.zip -C ${SCRIPT_PATH}/.. wlsdeploy
IMAGETOOL_PATH="${SCRIPT_PATH}/../tools/imagetool/bin/imagetool.sh"

CLEAR_CACHE_CMD="${IMAGETOOL_PATH} cache deleteEntry \
    --key wdt_latest"
ADD_INSTALLER_CMD="${IMAGETOOL_PATH} cache addInstaller \
    --type wdt \
    --version latest \
    --path ${SCRIPT_PATH}/../tools/weblogic-deploy.zip"

set -x; $CLEAR_CACHE_CMD; $ADD_INSTALLER_CMD; set +x

PACKAGE_CMD="${IMAGETOOL_PATH} \
    createAuxImage \
    --tag docker.io/ireshmm/wls-quickstart:1.0 \
    --wdtModel ${SCRIPT_PATH}/../model/model.yaml \
    --wdtVariables ${SCRIPT_PATH}/../model/model.properties \
    --wdtArchive /tmp/archive.zip"
    
set -x; $PACKAGE_CMD; set +x