# simple-nfs-server

#### 介绍
这是一个简单的 nfs server docker 镜像, 您可以使用 docker-compose 运行，也可以直接 `docker run`

#### docker-compose 使用说明
1.  执行命令授予执行脚本权限：`sed -i -e 's/\r$//' *.sh && chmod -R 755 *.sh`
2.  执行 `copy env.tpl .env`，并且配置 .env
3.  运行 ./run-docker.sh 【注：docker-compose 低版本识别不了 .env，需要进行升级，作者用的版本是: 1.29.2】
4.  查看日志: docker logs qiushaocloud-simple-nfs-server

#### docker 使用说明
1.  docker pull qiushaocloud/simple-nfs-server:latest
2.  运行 docker 镜像： `docker run -itd -p 2049:2049 -v /mnt/nfs:/mnt/nfs qiushaocloud/simple-nfs-server:latest`


#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


#### 分享者信息

1. 分享者邮箱: qiushaocloud@126.com
2. [分享者网站](https://www.qiushaocloud.top)
3. [分享者自己搭建的 gitlab](https://gitlab.qiushaocloud.top/qiushaocloud) 
3. [分享者 gitee](https://gitee.com/qiushaocloud/dashboard/projects) 
3. [分享者 github](https://github.com/qiushaocloud?tab=repositories) 