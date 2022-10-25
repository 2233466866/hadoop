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
   docker exec -it hadoop bash
   exp-starthd
   ```

1. 格式化文件结构
   ```
   hdfs namenode -format
   ```

1. 启动HDFS
   ```
   start-dfs.sh
   ```
