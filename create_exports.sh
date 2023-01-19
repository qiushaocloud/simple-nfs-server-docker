#!/bin/bash
set -o errexit

echo "start create exports"

echo "NFS_DIR_LIST: $NFS_DIR_LIST"
echo "NFS_IP_WHITE_LIST: $NFS_IP_WHITE_LIST"

if [ ! $NFS_DIR_LIST ];then
    echo "NFS_DIR_LIST is empty"
    exit 0
fi

if [ ! $NFS_IP_WHITE_LIST ];then
    echo "NFS_IP_WHITE_LIST is empty"
    exit 0
fi

ROOT_SHARE_DIR_TMP=$ROOT_SHARE_DIR
if [ ! $ROOT_SHARE_DIR_TMP ];then
    echo "entrypoint_ex ROOT_SHARE_DIR_TMP is empty, set default to /nfs_share_root_dirs"
    ROOT_SHARE_DIR_TMP="/nfs_share_root_dirs"
fi

NFS_DIR_LIST_TMP=(`echo $NFS_DIR_LIST | tr ';' ' '` )
NFS_IP_WHITE_LIST_TMP=(`echo $NFS_IP_WHITE_LIST | tr ';' ' '` )
for nfsDir in ${NFS_DIR_LIST_TMP[@]}
do
    echo "nfsDir: $nfsDir"

    line="$ROOT_SHARE_DIR_TMP$nfsDir"

    for allownfsIp in ${NFS_IP_WHITE_LIST_TMP[@]}
    do
        if [ $allownfsIp == "all" ];then
            echo "allownfsIp is all, need set to *"
	        line="$line *(rw,$NFS_EXPORT_SYNC,no_subtree_check,$NFS_EXPORT_SQUASH)"
        else
            echo "allownfsIp: $allownfsIp"
	        line="$line $allownfsIp(rw,$NFS_EXPORT_SYNC,no_subtree_check,$NFS_EXPORT_SQUASH)"
        fi
    done

    echo "line: $line"
    echo $line >> /etc/exports
done

