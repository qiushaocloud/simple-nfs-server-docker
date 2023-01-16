FROM qiushaocloud/ub1604-base:latest

RUN apt update \
	&& apt-get install -y nfs-kernel-server

COPY ./bootstarp.sh /root/bootstarp.sh

RUN chmod 777 /root/bootstarp.sh \
	&& mkdir /mnt/nfs \
	&& chmod -R 666 /mnt/nfs \
	&& chown -R nobody:nogroup /mnt/nfs \
	&& echo "/mnt/nfs *(rw,sync,no_subtree_check)" >> /etc/exports

WORKDIR /root

VOLUME ["/mnt/nfs"]
EXPOSE 2049

CMD ["/root/bootstarp.sh"]