FROM  centos
MAINTAINER  zengzhunzhun 
RUN rpm -ivh https://mirrors.tuna.tsinghua.edu.cn/epel/7/x86_64/e/epel-release-7-8.noarch.rpm
RUN rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm 
RUN sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/remi.repo
RUN yum install -y redis 
ADD redis.conf /etc/redis.conf
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 775 /docker-entrypoint.sh
EXPOSE 6379
CMD ["/docker-entrypoint.sh"]
