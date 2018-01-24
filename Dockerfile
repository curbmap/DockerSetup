FROM amazonlinux:1
# Add mongo repo
COPY mongodb-org-3.6.repo /etc/yum.repos.d/
RUN yum install -y wget curl
RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
RUN wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
RUN wget https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-6-x86_64/pgdg-ami201503-96-9.6-2.noarch.rpm
RUN rpm -i pgdg-ami201503-96-9.6-2.noarch.rpm
RUN yum update -y
RUN yum install -y mongodb-org gcc gcc-c++ make tcl git nodejs yarn jemalloc vim postgresql96 postgresql96-server postgresql96-devel postgresql96-contrib postgresql96-docs
RUN mkdir -p /data/db
RUN chown -R mongod:mongod /data
RUN service mongod start
RUN sleep 10
# Not really necessary, but mimicking an auth configuration (more rights than real curbmap test user has)
COPY testuser.js /
COPY testdb.js /
COPY setup_mongo.sh /
COPY mongod.conf /etc/
RUN chmod u+x setup_mongo.sh
RUN /setup_mongo.sh
# Restart Mongo with auth
RUN service mongod restart
# Install redis
WORKDIR /usr/local/src
RUN wget http://download.redis.io/releases/redis-4.0.4.tar.gz
RUN tar xzf redis-4.0.4.tar.gz
COPY setup_redis.sh /
RUN chmod u+x /setup_redis.sh
RUN /setup_redis.sh
WORKDIR /
COPY redis-server /etc/init.d/
RUN chmod 755 /etc/init.d/redis-server
COPY redis.conf /etc/redis
COPY setup_network.sh /
RUN chmod 755 /setup_network.sh
RUN /setup_network.sh
RUN service redis-server start
COPY setup_postgres.sh /
RUN chmod a+x /setup_postgres.sh
RUN mkdir /services
WORKDIR /services/
RUN git clone https://github.com/curbmap/curbmapbackend-js.git
RUN git clone https://github.com/curbmap/curbmapauth-js.git
COPY startscript.sh /services/
RUN chmod 755 /services/startscript.sh
COPY curbmap.env /services/
WORKDIR /
RUN sed -i 's/5432/9020/g' /etc/init.d/postgresql96
RUN service postgresql96 initdb
RUN sed -i 's/\#port = 5432/port = 9020/g' /var/lib/pgsql96/data/postgresql.conf
COPY builddb.sql /
RUN service postgresql96 stop
RUN service postgresql96 start && su postgres -c /setup_postgres.sh
WORKDIR /services/
COPY downloaddata.sh /services/
RUN chmod 755 downloaddata.sh
COPY updaterepos.sh /services
RUN chmod 755 /services/updaterepos.sh
EXPOSE 8081
EXPOSE 8080