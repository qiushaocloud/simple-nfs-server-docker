#!/bin/bash
set -o errexit

echo "start entrypoint.sh"

ROOT_SHARE_DIR_TMP=$ROOT_SHARE_DIR
if [ ! $ROOT_SHARE_DIR_TMP ];then
    echo "entrypoint ROOT_SHARE_DIR_TMP is empty, set default to /nfs_share_root_dirs"
    ROOT_SHARE_DIR_TMP="/nfs_share_root_dirs"
fi

echo "ROOT_SHARE_DIR_TMP: $ROOT_SHARE_DIR_TMP"
cd /app
bash create_nfs_dir.sh $ROOT_SHARE_DIR_TMP
root_dir_rwo='rw'
echo "NFS_DIR_LIST: $NFS_DIR_LIST"
if [ ! $NFS_DIR_LIST ] && [ ! "$EXTRA_EXPORTS" ];then
    echo "entrypoint NFS_DIR_LIST and EXTRA_EXPORTS is empty"
else
    echo "entrypoint ROOT_SHARE_DIR_TMP not empty, set root dir to ro,hide,secure"
    root_dir_rwo='ro,hide,secure'
fi

if [ ! $NFS_IP_WHITE_LIST ];then
    echo "entrypoint NFS_IP_WHITE_LIST is empty, need allow *"
    echo "$ROOT_SHARE_DIR_TMP *($root_dir_rwo,fsid=0,sync,no_subtree_check,all_squash)" > /etc/exports
else
    echo "entrypoint NFS_IP_WHITE_LIST not empty, need allow white list"
    line="$ROOT_SHARE_DIR_TMP"

    NFS_IP_WHITE_LIST_TMP=(`echo $NFS_IP_WHITE_LIST | tr ';' ' '` )
    for allownfsIp in ${NFS_IP_WHITE_LIST_TMP[@]}
    do
        if [ $allownfsIp == "all" ];then
            echo "entrypoint allownfsIp is all, need set to *"
            line="$line *($root_dir_rwo,fsid=0,sync,no_subtree_check,all_squash)"
        else
            echo "entrypoint allownfsIp: $allownfsIp"
            line="$line $allownfsIp($root_dir_rwo,fsid=0,sync,no_subtree_check,all_squash)"
        fi
    done

    echo "line: $line"
    echo $line > /etc/exports
fi

echo "run create_nfs_dirs.sh"
cd /app
bash create_nfs_dirs.sh

echo "run create_exports.sh"
cd /app
bash create_exports.sh

if [ "$EXTRA_EXPORTS" ];then
    echo "EXTRA_EXPORTS is not empty, need append to /etc/exports, EXTRA_EXPORTS: $EXTRA_EXPORTS"
    EXTRA_EXPORTS_TMP=`echo $EXTRA_EXPORTS | sed 's/;/\r\n/g'`
    echo "$EXTRA_EXPORTS_TMP" >> /etc/exports
fi

echo "run start-nfs.sh"
cd /app
bash start-nfs.sh