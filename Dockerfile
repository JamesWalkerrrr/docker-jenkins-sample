#Version 0.0.1
FROM centos:centos7
MAINTAINER joooohnson "zhangwangqing@163.com"
ENV REFRESHED_AT 2017-07-31
RUN yum -y update;yum clean all &&\
    yum -y install epel-release tar;yum clean all &&\
    yum -y install nginx;yum clean all
RUN mkdir -p /var/www/html/website
ADD nginx/global.conf /etc/nginx/conf.d/
ADD nginx/nginx.conf /etc/nginx/nginx.conf
ENTRYPOINT ["/usr/sbin/nginx","-g","daemon off;"]
EXPOSE 80
