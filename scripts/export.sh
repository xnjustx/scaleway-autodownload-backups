#!/bin/bash

#################################################
#	Created by XNJUSTX
#	Systems & Networks Administrator
#################################################

# Initialize the basedir
BASEDIR=$(realpath "$0" | sed 's/export.sh//g')
#echo "$BASEDIR"
cd $BASEDIR

#sleep 1000

# Initialize image and path of config & backups
IMG="scw:latest"
PTH=$(echo $BASEDIR"/root" | sed 's/\/scripts//g')
#PTH="../root"

# Loop to prepare export all images
while read p; do
  ID=$(echo "$p" | awk '{print $1}')
  NAME=$(echo "$p" | awk '{print $2}')
  echo "--- Export backup of $NAME ---"
  docker run --rm -v $PTH:/root $IMG rdb backup export $ID
  echo ""
done < to_export.txt

# Wait a moment for all images exported
if [ -s to_export.txt ]
then
  echo "[\e[01;37m--- Sleep to wait end of export ---\e[00m"
  sleep 100
else
  echo -e "\e[32m   --- Nothing to export, don't sleep and download now ---\e[00m"
fi
echo ""

# Loop to download all images and rename them
while read p; do
  ID=$(echo "$p" | awk '{print $1}')
  NAME=$(echo "$p" | awk '{print $2}')
  echo -e "\e[01;37m--- Download backup of $NAME ---\e[00m"
  docker run --rm -v $PTH:/root $IMG rdb backup download $ID
  if [ -f $PTH/$ID.sql.gz ]
  then
    echo -e "\e[01;37m---- moving $ID.sql.gz to $NAME.sql.gz ---\e[00m"
    mv $PTH/$ID.sql.gz $PTH/$NAME.sql.gz
  elif [ -f $PTH/$ID.custom ]
  then
    echo -e "\e[01;37m---- moving $ID.custom to $NAME.custom ---\e[00m"
    mv $PTH/$ID.custom $PTH/$NAME.custom
  else
    echo -e "\e[31mFile not found, can't move backup $ID to $NAME\e[00m"
  fi
  echo ""
done < all_to_export.txt
