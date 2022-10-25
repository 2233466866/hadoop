## 快速开始

1. 创建镜像
   ```
   docker build -t hadoop .
   ```

1. 生成容器
   ```
   docker run -dit --name=hadoop hadoop:latest
   ```

1. 首次使用
   ```
   # 进入容器执行命令
   docker exec -it hadoop bash
   
   # 给容器root用户指定密码并开启ssh免密登录
   exp-starthd [给容器root用户指定的密码]
   
   # 配置core-site.xml
   sed -i s/"LOCALHOST"/"`hostname`"/g /usr/local/hadoop3/etc/hadoop/core-site.xml
   
   # 格式化文件结构
   hdfs namenode -format
   
   # 启动HDFS
   start-dfs.sh
   ```
