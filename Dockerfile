FROM centos:6.8

MAINTAINER EXASOL "service@exasol.com"

RUN yum update -y --exclude=kernel* && yum install -y java-1.8.0-openjdk-headless openssh-server openssh-client which sudo vim tar rsync && yum clean all

LABEL name="EXASOL DB Docker Image" version="6.0.2-d1" dbversion="6.0.2" osversion="6.0.2" reversion="6.0.2" license="Proprietary" vendor="EXASOL AG"

COPY license.xml     /.license.xml
ADD EXAClusterOS-6.0.2_LS-DOCKER-CentOS-6.8_x86_64.tar.gz              /
ENV PATH=/usr/opt/EXASuite-6/EXAClusterOS-6.0.2/bin:/usr/opt/EXASuite-6/EXAClusterOS-6.0.2/sbin:/usr/opt/EXASuite-6/EXARuntime-6.0.2/bin:/usr/opt/EXASuite-6/EXARuntime-6.0.2/sbin:/usr/op/EXASuite-6/EXASolution-6.0.2/bin/Console:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin 

ENTRYPOINT ["/usr/opt/EXASuite-6/EXAClusterOS-6.0.2/devel/docker/exadt", "init-sc"]
