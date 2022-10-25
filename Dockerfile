FROM centos:7.9.2009
ADD * /root/
# 时区修改
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime;\
# YUM源修改
\cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak;\
\cp -f /root/Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo;\
yum install epel-release;\
# ssh & expect
yum install openssh-clients openssh-server initscripts expect -y;\
# 生成脚本
\cp /root/exp-keygen /usr/bin/exp-keygen;\
chmod -R 755 /usr/bin/exp-keygen;\
/usr/bin/exp-keygen;\
\cp /root/exp-copyid /usr/bin/exp-copyid;\
chmod -R 755 /usr/bin/exp-copyid;\
\cp /root/exp-starthd /usr/bin/exp-starthd;\
chmod -R 755 /usr/bin/exp-starthd;\
\mv /usr/bin/systemctl /usr/bin/systembak;\
\cp /root/systemctl /usr/bin/systemctl;\
chmod -R 755 /usr/bin/systemctl;\
# 开始安装
cd /root/;\
curl https://mirrors.aliyun.com/apache/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz -o apache-maven-3.8.6.tar.gz;\
tar -xf apache-maven-3.8.6.tar.gz;\
curl https://mirrors.aliyun.com/apache/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz -o hadoop-3.3.4.tar.gz;\
tar -xf hadoop-3.3.4.tar.gz;\
curl https://download.java.net/java/GA/jdk18.0.2.1/db379da656dc47308e138f21b33976fa/1/GPL/openjdk-18.0.2.1_linux-x64_bin.tar.gz -o openjdk-18.tar.gz;\
tar -xf openjdk-18.tar.gz;\
\mv /root/jdk-18.0.2.1 /usr/local/jdk18;\
\mv /root/apache-maven-3.8.6 /usr/local/maven3;\
\mv /root/hadoop-3.3.4 /usr/local/hadoop3;\
\cp -f /root/stop-all.sh /usr/local/hadoop3/sbin/stop-all.sh;\
\cp -f /root/start-all.sh /usr/local/hadoop3/sbin/start-all.sh;\
\cp -f /root/stop-dfs.sh /usr/local/hadoop3/sbin/stop-dfs.sh;\
\cp -f /root/start-dfs.sh /usr/local/hadoop3/sbin/start-dfs.sh;\
\cp -f /root/stop-yarn.sh /usr/local/hadoop3/sbin/stop-yarn.sh;\
\cp -f /root/start-yarn.sh /usr/local/hadoop3/sbin/start-yarn.sh;\
\cp -f /root/hdfs-site.xml /usr/local/hadoop3/etc/hadoop/hdfs-site.xml;\
\cp -f /root/core-site.xml /usr/local/hadoop3/etc/hadoop/core-site.xml;\
echo "export JAVA_HOME=/usr/local/jdk18" >> /usr/local/hadoop3/etc/hadoop/hadoop-env.sh;\
echo "export HADOOP_HOME=/usr/local/hadoop3" >> /usr/local/hadoop3/etc/hadoop/hadoop-env.sh;\
chown -R root:root /usr/local/hadoop3;\
# 清理文件
rm -rf /root/*
# 暴露端口
EXPOSE 22 9000 9001 50070 50470 50100 50105 50090 50091 50020 50075 50475 50010 \
8480 8481 8032 8088 8090 8030 8031 8033 8042 8040 8188 10020 19888 2888 3888 \
2181 60010 60000 60030 60020 8080 10000 9083
# 环境变量
ENV JAVA_HOME="/usr/local/jdk18" \
JRE_HOME="/usr/local/jdk18/jre" \
CLASSPATH=".:/usr/local/jdk18/lib/dt.jar:/usr/local/jdk18/lib/tools.jar:/usr/local/jdk18/jre/lib" \
HADOOP_HOME="/usr/local/hadoop3" \
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/jdk18/bin:/usr/local/jdk18/jre/bin:/usr/local/maven3/bin:/usr/local/hadoop3/sbin:/usr/local/hadoop3/bin"
# 运行容器
CMD /usr/bin/systemctl