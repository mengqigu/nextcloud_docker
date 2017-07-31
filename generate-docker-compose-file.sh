#!/bin/bash

read -p "Please enter the absolute path to your nextcloud source code root \
folder (no space, no trailing forward slash): " nexcloudPath
read -p "Please create a folder named db_data and enter the absolute path to \
this folder. (no space, no trailing forward slash): " dbDataPath

sed 's|${NEXTCLOUD_PATH}|'$nexcloudPath'|g; s|${DB_DATA_PATH}|'$dbDataPath'|g' \
template.yml > docker-compose.yml
