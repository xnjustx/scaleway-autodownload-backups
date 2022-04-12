# Script to automate download of Scaleway DB AutoBackup

UNOFFICIAL Script to automate downloads of Scaleway DB Autobackups.
This repository is not maintained.

This script only work with MYSQL and POSTGRES Databases.
Others DB will be backed up but not renamed with the backup name setted up by Scaleway console.

Based on official scaleway-cli repository and image <a href=https://github.com/scaleway/scaleway-cli>https://github.com/scaleway/scaleway-cli</a>

Created by XNJUSTX (Fr).

## Pre-Required

You need to install following packages :
  - GIT
```
# Debian / Ubuntu
apt install git
# CentOS
yum install git
# Alpine
apk add git
```
  - CURL
```
# Debian / Ubuntu
apt install curl
# CentOS
yum install curl
# Alpine
apk add curl
```
  - DOCKER
```
# All systems using bash
curl https://get.docker.com | bash
# All systems using sh
curl https://get.docker.com | sh
```

## Get started

Clone the repo :
```
git clone <URL>
cd scaleway-backup-db
```

At first, build the image of scaleway-cli (Based on official image but modified for this script)
```
docker build ./docker-build -t scw:latest
```

Before launching script, you need an authentification to scaleway API.<br>
Go to the scaleway console and create a new API-Key, then run the command below and follow the configuration in prompt :
```
docker run -it --rm -v $(pwd)/root:/root scw:latest init
```

## Launch script

Launch with logs in stdout :
```
./scripts/get.sh
```

Launch in background :
```
./scripts/get.sh > scripts/log-export.log &
```

## Where are stored the backups

You can find backups inside of the "root" folder.<br>
All the MYSQL backups will be named *.sql.gz<br>
All the POSTGRES backups will be named *.custom
