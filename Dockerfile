FROM openjdk:8-jdk-slim

MAINTAINER Matthias Nuessler <m.nuessler@web.de>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -y --fix-missing install \
        graphviz \
        subversion \
        maven \
        less \
        libpostgresql-jdbc-java \
        libmysql-java && \
    svn checkout -r 662 svn://svn.code.sf.net/p/schemaspy/code/trunk /usr/src/schemaspy && \
    perl -p -i -e 's/(driverPath=).*/\1\/usr\/share\/java\/mysql-connector-java\.jar/g' \
    /usr/src/schemaspy/src/main/resources/net/sourceforge/schemaspy/dbTypes/mysql.properties && \
    mvn -f /usr/src/schemaspy/pom.xml package && \
    mkdir /opt/schemaspy && \
    mv /usr/src/schemaspy/target/schemaspy-5.0.0.jar /opt/schemaspy/schemaspy.jar && \
    rm -Rf ~/.m2 /usr/src/schemaspy && \
    DEBIAN_FRONTEND=noninteractive apt-get -y remove subversion maven && \
    DEBIAN_FRONTEND=noninteractive apt-get -y autoremove && \
    apt-get clean

COPY start.sh /

CMD ["--help"]
ENTRYPOINT ["/start.sh"]
