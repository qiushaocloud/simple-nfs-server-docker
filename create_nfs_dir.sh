#!/bin/bash
set -o errexit

NFS_DIR=$1
ROOT_SHARE_DIR_TMP=$2
echo "NFS_DIR: $NFS_DIR"
echo "ROOT_SHARE_DIR_TMP: $ROOT_SHARE_DIR_TMP"

if [ ! $NFS_DIR ];then
    echo "NFS_DIR is empty"
    exit 0
fi

if [ $IS_DOCKER_ENV == "yes" ] && [ $ROOT_SHARE_DIR_TMP ];then
    if [ ! -d $ROOT_SHARE_DIR_TMP$NFS_DIR ]; then
        echo "docker dir $ROOT_SHARE_DIR_TMP$NFS_DIR have already existed"
        exit 0
    fi

    echo "create docker dir $ROOT_SHARE_DIR_TMP$NFS_DIR"
    mkdir -p $ROOT_SHARE_DIR_TMP$NFS_DIR

    echo "chown docker dir $ROOT_SHARE_DIR_TMP$NFS_DIR"
    chown -R nobody:nogroup $ROOT_SHARE_DIR_TMP$NFS_DIR

    echo "chmod docker dir $ROOT_SHARE_DIR_TMP$NFS_DIR"
    chmod 777 $ROOT_SHARE_DIR_TMP$NFS_DIR
else
    if [ ! -d $NFS_DIR ]; then
        echo "dir $NFS_DIR have already existed"
        exit 0
    fi
    echo "create dir $NFS_DIR"
    mkdir -p $NFS_DIR

    echo "chown dir $NFS_DIR"
    chown -R nobody:nogroup $NFS_DIR

    echo "chmod dir $NFS_DIR"
    chmod 777 $NFS_DIR
fi


