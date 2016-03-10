# docker full file 

FROM centos:latest
ADD /resources/jboss-fuse-full-6.2.1.redhat-084.zip /tmp/
RUN yum -y update
RUN useradd fuse
RUN yum -y install wget unzip java-1.7.0-openjdk-devel git which tar

#centosbase:v1

RUN mkdir -m 777 -p /opt/fuse
RUN unzip /tmp/jboss-fuse-full-6.2.1.redhat-084.zip -d /opt/fuse
RUN sed -i '/#admin/s/^#//g' /opt/fuse/jboss-fuse-6.2.1.redhat-084/etc/users.properties
RUN sed -i 's/root/fabric/g' /opt/fuse/jboss-fuse-6.2.1.redhat-084/etc/system.properties
RUN echo 'bash /opt/fuse/jboss-fuse-6.2.1.redhat-084/bin/start' >> /root/.bashrc

#fusebase:v1

# maven
RUN cd /usr/local
RUN wget ftp://mirror.reverse.net/pub/apache/maven/maven-3/3.3.1/binaries/apache-maven-3.3.1-bin.tar.gz
RUN tar -xzvf apache-maven-3.3.1-bin.tar.gz -C /usr/local/
RUN rm -rf apache-maven-3.3.1-bin.tar.gz
RUN cd /usr/local/ && mv apache-maven-3.3.1 maven
RUN echo 'export M2_HOME=/usr/local/maven' > /etc/profile.d/maven.sh
RUN echo 'export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh
RUN echo 'export PATH=${M2_HOME}:${PATH}' >> /etc/profile.d/maven.sh
RUN source /etc/profile
RUN mkdir -p ~/.m2
RUN rm -rf ~/.m2/settings.xml

#mavenbase:v1

