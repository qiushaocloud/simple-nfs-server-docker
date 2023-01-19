#!/bin/bash
set -o errexit

echo "start create dirs"

ROOT_SHARE_DIR_TMP=$ROOT_SHARE_DIR
if [ ! $ROOT_SHARE_DIR_TMP ];then
    echo "entrypoint_ex ROOT_SHARE_DIR_TMP is empty, set default to /nfs_share_root_dirs"
    ROOT_SHARE_DIR_TMP="/nfs_share_root_dirs"
fi

echo "NFS_DIR_LIST: $NFS_DIR_LIST"
if [ ! $NFS_DIR_LIST ];then
    echo "NFS_DIR_LIST is empty"
    exit 0
fi

NFS_DIR_LIST_TMP=(`echo $NFS_DIR_LIST | tr ';' ' '` )
for nfsDir in ${NFS_DIR_LIST_TMP[@]}
do
    echo "nfsDir: $nfsDir"
    bash create_nfs_dir.sh $nfsDir $ROOT_SHARE_DIR_TMP
done

echo "NFS_NEED_CREATE_DIR_LIST: $NFS_NEED_CREATE_DIR_LIST"
if [ ! $NFS_NEED_CREATE_DIR_LIST ];then
    echo "NFS_NEED_CREATE_DIR_LIST is empty"
    exit 0
fi

NFS_NEED_CREATE_DIR_LIST_TMP=(`echo $NFS_NEED_CREATE_DIR_LIST | tr ';' ' '` )
for needCreateDir in ${NFS_NEED_CREATE_DIR_LIST_TMP[@]}
do
    echo "needCreateDir: $needCreateDir"
    bash create_nfs_dir.sh $needCreateDir
done