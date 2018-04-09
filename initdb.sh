#!/bin/bash

for DIR in $(find $(pwd) -type d -name "*miniconda*" -print)
do
	MINICONDA_PATH=$DIR
	ENV_NAME=$(ls -lt $MINICONDA_PATH/envs |tail -n +2 |head -1|awk '{print $NF}')
	source ${MINICONDA_PATH}/bin/activate ${ENV_NAME}
	# Wait for ENV to load
	printf "\nWaiting for ENV to load.."
	while [$(type -t tethys_start_db) != 'alias' ];do
		printf "."
	done
	printf "\nStarting Server for Env: ${ENV_NAME} located at ${MINICONDA_PATH}\n"
	tethys_start_db
	source ${MINICONDA_PATH}/bin/deactivate ${ENV_NAME}
done