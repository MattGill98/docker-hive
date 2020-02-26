FROM bde2020/hive:2.3.2-postgresql-metastore

ADD config.hql $HIVE_HOME/conf
ADD data.csv .

ADD run_tests.sh .

COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh
