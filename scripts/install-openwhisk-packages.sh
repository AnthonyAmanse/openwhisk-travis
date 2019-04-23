#!/bin/bash

pushd incubator-openwhisk-devtools/docker-compose

# add system packages
make add-catalog
make create-provider-alarms
make create-provider-kafka
make create-provider-cloudant

popd
wsk -i list
wsk -i package list /whisk.system
wsk -i action invoke /whisk.system/utils/echo --param message "Hello, World!" --result
