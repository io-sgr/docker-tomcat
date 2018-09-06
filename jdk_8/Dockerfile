FROM sgrio/java-oracle:jdk_8
MAINTAINER SgrAlpha <admin@mail.sgr.io>

ENV DEBIAN_FRONTEND=noninteractive \
    CATALINA_HOME="/opt/apache-tomcat" \
    PATH="/opt/apache-tomcat/bin:$PATH"

RUN TOMCAT_VERSION=7.0.88 && \
    APR_VERSION=1.6.3 && \
    TC_NATIVE_VERSION=1.2.17 && \
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
    apt-get update && apt-get install \
        gcc \
        libc6-dev \
        libssl-dev \
        libfile-dircompare-perl \
        make \
        -y --no-install-recommends && \
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
    apt-get remove --purge --auto-remove -y \
        gcc \
        libc6-dev \
        libssl-dev \
        libfile-dircompare-perl \
        make && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8005 8080 8009 8443 45564 4000

WORKDIR ${CATALINA_HOME}

CMD ${CATALINA_HOME}/bin/catalina.sh run
