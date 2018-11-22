FROM centos:centos7
MAINTAINER zhangwq "zhangwangqing@163.com"

# Update packages
RUN yum -y update;yum clean all &&\
    yum -y install epel-release tar;yum clean all

# Install Node.js
RUN yum install -y nodejs npm

# Install MongoDB
RUN yum install -y mongodb-server

# Install Supervisord
RUN yum install -y python-setuptools
RUN easy_install supervisor

# Copy Supervisord files into the image
ADD supervisord.conf /etc/supervisord.conf
ADD supervisord.d    /etc/supervisord.d

# Expose 3000
EXPOSE 3000

# Run Supervisord on image start
# It could be just "supervisord", but let's get rid of a few WARNing messages.
CMD ["supervisord", "-c", "/etc/supervisord.conf"]

