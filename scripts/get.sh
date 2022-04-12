#!/bin/bash

#################################################
#	Created by XNJUSTX
#	Systems & Networks Administrator
#################################################

# Init image for docker
IMG="scw:latest"

# Initialize the basedir
BASEDIR=$(realpath "$0" | sed 's/get.sh//g')
#echo "$BASEDIR"
cd $BASEDIR

cd ../

############################################################
# exporte toutes les instances et toutes les colonnes
############################################################
docker run --rm -v $(pwd)/root:/root $IMG rdb backup list order-by=created_at_desc | grep -v "days ago" | grep -v 'day ago' | grep ready | awk '{print $1" "$4" "$20}' | grep -v "rdb"> scripts/all_to_export.txt

echo "" > to_export.txt
cat scripts/all_to_export.txt | sed 's/ -/ ?/g' | grep "?" > scripts/to_export.txt

cd scripts

./export.sh
