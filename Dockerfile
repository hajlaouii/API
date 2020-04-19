FROM centos:7


RUN yum -y update && \
    yum -y clean all && \
    yum -y install dos2unix && \
    yum -y install java-1.8.0-openjdk



ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64
ENV PATH=$PATH:$JAVA_HOME/bin

RUN groupadd bulksmsgroup
RUN useradd -g bulksmsgroup bulksmsusr
RUN echo "bulksmspwd" | passwd --stdin bulksmsusr


RUN mkdir /opt/mysql-client
COPY ./mysql-community-client-5.6.37-2.el7.x86_64.rpm /opt/mysql-client
COPY ./mysql-community-libs-5.6.37-2.el7.x86_64.rpm /opt/mysql-client
COPY ./mysql-community-common-5.6.37-2.el7.x86_64.rpm /opt/mysql-client

WORKDIR /opt/mysql-client
RUN rpm -ivh mysql-community-common-5.6.37-2.el7.x86_64.rpm
RUN rpm -ivh mysql-community-libs-5.6.37-2.el7.x86_64.rpm
RUN rpm -ivh mysql-community-client-5.6.37-2.el7.x86_64.rpm --nodeps


RUN mkdir –p /opt/API_G4R23C0
COPY ./API_G4R23C0 /opt/API_G4R23C0

WORKDIR /opt/API_G4R23C0
RUN dos2unix start




EXPOSE 9191


CMD /opt/API_G4R23C0/start && tail -f /dev/null


