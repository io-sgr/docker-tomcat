FROM centos:7
MAINTAINER SgrAlpha <admin@sgr.io>

ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_HOME="/usr/lib/jvm/java" \
    CATALINA_HOME="/opt/apache-tomcat" \
    PATH="/opt/apache-tomcat/bin:$PATH"

EXPOSE 8005 8080 8009 8443 45564 4000

RUN TOMCAT_VERSION=7.0.96 && \
    APR_VERSION=1.7.0 && \
    TC_NATIVE_VERSION=1.2.23 && \
    yum update -y && \
    yum install -y \
        java-1.8.0-openjdk-devel && \
    curl --silent --location --retry 3 \
        http://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
        | tar xz -C /tmp && \
    mv /tmp/apache-tomcat-${TOMCAT_VERSION} /opt/apache-tomcat-${TOMCAT_VERSION} && \
    ln -s /opt/apache-tomcat-${TOMCAT_VERSION} ${CATALINA_HOME} && \
    rm -rf ${CATALINA_HOME}/bin/*.bat \
        ${CATALINA_HOME}/bin/*.exe \
        ${CATALINA_HOME}/bin/*.tar.gz \
        ${CATALINA_HOME}/bin/*.original \
        ${CATALINA_HOME}/conf/*.original \
        ${CATALINA_HOME}/logs/* \
        ${CATALINA_HOME}/temp/* \
        ${CATALINA_HOME}/webapps/* \
        ${CATALINA_HOME}/work/* && \
    yum install -y \
        gcc \
        make \
        openssl-devel && \
    curl --silent --location --retry 3 \
        http://archive.apache.org/dist/apr/apr-${APR_VERSION}.tar.gz \
        | tar xz -C /tmp && \
    cd /tmp/apr-${APR_VERSION} && \
        ./configure && \
        make clean && make && make install && \
    ln -s /usr/local/apr/lib/libapr-1.so.0 /usr/lib/libapr-1.so.0 && \
    ln -s /usr/local/apr/lib/libapr-1.so /usr/lib/libapr-1.so && \
    curl --silent --location --retry 3 \
        http://archive.apache.org/dist/tomcat/tomcat-connectors/native/${TC_NATIVE_VERSION}/source/tomcat-native-${TC_NATIVE_VERSION}-src.tar.gz \
        | tar xz -C /tmp && \
    cd /tmp/tomcat-native-${TC_NATIVE_VERSION}-src/native && \
        ./configure -with-apr=/usr/local/apr/ -with-ssl=yes -with-java-home=${JAVA_HOME} && \
        make clean && make && make install && \
    ln -s /usr/local/apr/lib/libtcnative-1.so.0 /usr/lib/libtcnative-1.so.0 && \
    ln -s /usr/local/apr/lib/libtcnative-1.so /usr/lib/libtcnative-1.so && \
    yum remove -y \
        gcc \
        make \
        openssl-devel && \
    yum autoremove -y && yum clean all && \
    rm -rf /var/cache/yum /tmp/* /var/tmp/*

WORKDIR ${CATALINA_HOME}

CMD ${CATALINA_HOME}/bin/catalina.sh run
