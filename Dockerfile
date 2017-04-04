FROM centos:6
MAINTAINER Yasushi Kobayashi <ptpadan@gmail.commv>

RUN yum -y update && \
    yum -y install git

RUN yum -y install epel-release && \
    curl -O http://rpms.famillecollet.com/enterprise/remi-release-6.rpm && \
    rpm -Uvh remi-release-6*.rpm && \
    yum -y install --enablerepo=remi --enablerepo=remi-php70 php php-devel php-mbstring php-pdo php-gd php-mysqlnd php-openssl php-mcrypt

RUN yum -y install httpd && \
    chkconfig httpd on

RUN yum -y install http://repo.mysql.com/mysql-community-release-el6-4.noarch.rpm && \
    yum -y install mysql-community-server && \
    service mysqld start && \
    chkconfig mysqld on

RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
    yum --enablerepo=epel install redis

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /var/www/html

RUN git clone git://github.com/creationix/nvm.git ~/.nvm && \
    echo 'source ~/.nvm/nvm.sh' >> ~/.bash_profile  && \
    source ~/.nvm/nvm.sh  && \
    nvm install v6.7.0  && \
    npm i -g yarn

CMD service httpd start && service mysqld start
