FROM centos:7.4.1708

LABEL maintainer="Michael Chi <chicong@outlook.com>"

WORKDIR /root

RUN yum install -y wget openssh openssh-clients openssh-server java-1.8.0-openjdk-devel

RUN ssh-keygen -A

RUN ssh-keygen -t rsa -b 4096 -P '' -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    && chmod 600 ~/.ssh/authorized_keys

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk

RUN mkdir -p ~/hadoop/hdfs/namenode \
    && mkdir -p ~/hadoop/hdfs/datanode

#RUN wget http://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-3.0.0/hadoop-3.0.0.tar.gz \
#    && tar -C /opt -zxvf hadoop-3.0.0.tar.gz \
#    && rm -f hadoop-3.0.0.tar.gz

COPY hadoop-3.0.0.tar.gz /root

RUN tar -C /opt -zxvf hadoop-3.0.0.tar.gz \
    && rm -f hadoop-3.0.0.tar.gz

ENV HADOOP_HOME=/opt/hadoop-3.0.0

ENV HDFS_NAMENODE_USER=root

ENV HDFS_DATANODE_USER=root

ENV HDFS_SECONDARYNAMENODE_USER=root

ENV YARN_RESOURCEMANAGER_USER=root

ENV YARN_NODEMANAGER_USER=root

COPY config/core-site.xml ${HADOOP_HOME}/etc/hadoop

COPY config/hdfs-site.xml ${HADOOP_HOME}/etc/hadoop

COPY config/mapred-site.xml ${HADOOP_HOME}/etc/hadoop

COPY config/yarn-site.xml ${HADOOP_HOME}/etc/hadoop

COPY config/hadoop-env.sh ${HADOOP_HOME}/etc/hadoop

COPY config/workers ${HADOOP_HOME}/etc/hadoop

COPY start-all.sh ${HOME}

RUN mkdir -p ${HADOOP_HOME}/logs

RUN ${HADOOP_HOME}/bin/hdfs namenode -format

RUN mkdir -p ~/hadoop/tmp

RUN rm -rf /tmp/*

CMD ["bash","-c","/usr/sbin/sshd -D"]
