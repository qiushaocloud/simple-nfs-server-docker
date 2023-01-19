# simple-nfs-server

#### 介绍
这是一个简单的 nfs server docker 镜像, 您可以使用 docker-compose 运行，也可以直接 `docker run`

#### docker-compose 使用说明
1.  执行命令授予执行脚本权限：`sed -i -e 's/\r$//' *.sh && chmod -R 755 *.sh`
2.  根据自己的需求修改 docker-compose.yaml 文件，文件里面有相关注解
3.  运行docker容器：`docker-compose up -d`
4.  查看日志: docker logs qiushaocloud-simple-nfs-server

#### docker 使用说明
1.  docker pull qiushaocloud/simple-nfs-server:latest
2.  运行 docker 镜像： `docker run -itd --privileged -p 2049:2049 -p 2049:2049/udp -v /mnt/nfs_share_root_dirs:/nfs_share_root_dirs qiushaocloud/simple-nfs-server:latest`

#### 注意事项
1. 容器内根共享目录为 `/nfs_share_root_dirs`
2. 必须在宿主机映射目录到容器里的根目录
3. 其它目录映射，docker 里面映射的目录必须在根目录下
4. 必须给容器 privileged 权限

### 环境变量
```yaml
environment:
    - NFS_IP_WHITE_LIST=all # 【可选】允许访问的白名单, 默认为 all, 以“;”分隔，比如: 10.1..0/16;192.168.2.0/24;192.168.7.22【all表示允许所有，还可以限定网段和固定ip】
    - NFS_DIR_LIST= # 【可选】其它共享目录，必须在 volumes 中对应映射宿主机目录，默认为空(表示使用根目录共享)， 以“;”分隔，比如: /mnt/nfs_share01;/mnt/nfs_share02【注意：一旦设置了共享目录，那么根目录将只支持读】
```

#### docker-compose.yaml 示例
```yaml
version: "3"
services:
  qiushaocloud-simple-nfs-server:
    image: qiushaocloud/simple-nfs-server
    container_name: qiushaocloud-simple-nfs-server
    hostname: qiushaocloud-simple-nfs-server
    privileged: true # 必须开启特权
    ports:
      - "2049:2049" # 外部 tcp 访问的端口
      - "2049:2049/udp" # 外部 udp 访问的端口
    volumes:
      - /mnt/nfs_share_root_dirs:/nfs_share_root_dirs # 【必选】共享根目录对应的宿主机目录映射【注意： 这个是必须的】
      # - /mnt/nfs_share01:/nfs_share_root_dirs/mnt/nfs_share01 # 【可选】其它目录映射，docker 里面映射的目录必须在根目录下
      # - /mnt/nfs_share02:/nfs_share_root_dirs/mnt/nfs_share02 # 【可选】其它目录映射，docker 里面映射的目录必须在根目录下
    environment:
      - NFS_IP_WHITE_LIST=all # 【可选】允许访问的白名单, 默认为 all, 以“;”分隔，比如: 10.1..0/16;192.168.2.0/24;192.168.7.22【all表示允许所有，还可以限定网段和固定ip】
      - NFS_DIR_LIST= # 【可选】其它共享目录，必须在 volumes 中对应映射宿主机目录，默认为空(表示使用根目录共享)， 以“;”分隔，比如: /mnt/nfs_share01;/mnt/nfs_share02【注意：一旦设置了共享目录，那么根目录将只支持读】
```

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