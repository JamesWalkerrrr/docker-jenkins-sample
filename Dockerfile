FROM centos:centos7
MAINTAINER zhangwq "zwq4work@gmail.com"
ENV REFESHED_AT 20181101

RUN yum clean all -y && yum update -y &&\
    yum groupinstall -y "Development Tools" &&\
    yum -y install wget curl which ruby ruby-dev build-essential redis-tools

RUN cd /tmp &&\
    wget  http://ftp.ruby-lang.org/pub/ruby/2.5/ruby-2.5.0.tar.gz &&\
    tar -xvzf ruby-2.5.0.tar.gz &&\
    cd ruby-2.5.0/ && ./configure --prefix=/usr/local; make; make install &&\
    ruby -v

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io|bash -s stable &&\
    source /etc/profile.d/rvm.sh
RUN /usr/local/rvm/bin/rvm requirements

#gem 安装时报错 ERROR: Loading command: install (LoadError) cannot load such file -- zlib  按照下列方法操作可解决

RUN cd /tmp/ruby-2.5.0/ext/zlib &&  ruby ./extconf.rb &&\
    sed -i 's#$(top_srcdir)\/include\/ruby.h#../../include/ruby.h#g' Makefile &&\
    make;make install

RUN cd /tmp/ruby-2.5.0/ext/openssl &&  ruby ./extconf.rb &&\
    sed -i 's#$(top_srcdir)\/include\/ruby.h#../../include/ruby.h#g' Makefile &&\
    make;make install

RUN gem install --no-rdoc --no-ri rspec ci_reporter_rspec
