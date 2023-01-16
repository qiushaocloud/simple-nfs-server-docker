docker rm -f simple-nfs-server || true
docker run -it --name simple-nfs-server -h simple-nfs-server qiushaocloud/simple-nfs-server