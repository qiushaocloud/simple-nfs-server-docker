FROM alpine:latest

ENV ROOT_SHARE_DIR "/nfs_share_root_dirs"
ENV IS_DOCKER_ENV "yes"
ENV NFS_IP_WHITE_LIST "all"
ENV NFS_DIR_LIST ""
ENV NFS_NEED_CREATE_DIR_LIST ""

RUN apk --update --no-cache add bash nfs-utils

COPY create_nfs_dir.sh /app/create_nfs_dir.sh
COPY create_nfs_dirs.sh /app/create_nfs_dirs.sh
COPY create_exports.sh /app/create_exports.sh
COPY entrypoint.sh /app/entrypoint.sh
COPY start-nfs.sh /app/start-nfs.sh

RUN mkdir -p /var/lib/nfs/rpc_pipefs \
	&& mkdir -p /var/lib/nfs/v4recovery \
    && echo "rpc_pipefs  /var/lib/nfs/rpc_pipefs  rpc_pipefs  defaults  0  0" >> /etc/fstab \
    && echo "nfsd        /proc/fs/nfsd            nfsd        defaults  0  0" >> /etc/fstab \
	&& chmod +x /app/*.sh

WORKDIR /app

EXPOSE 2049

ENTRYPOINT [""]
CMD ["/app/entrypoint.sh"]