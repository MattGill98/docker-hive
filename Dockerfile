FROM bde2020/hive:2.3.2-postgresql-metastore

ADD conf/hive-site.xml $HIVE_HOME/conf

ADD config.hql $HIVE_HOME/conf
ADD climatedata.csv .
ADD worldcities.csv .

COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh
