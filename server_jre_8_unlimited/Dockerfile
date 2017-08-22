FROM sgrio/java-oracle:server_jre_8_unlimited
MAINTAINER SgrAlpha <admin@mail.sgr.io>

ENV DEBIAN_FRONTEND noninteractive

ENV TOMCAT_VERSION 7.0.81
ENV APR_VERSION 1.6.2
ENV TC_NATIVE_VERSION 1.2.42
ENV OPENSSL_VERSION 1.0.2l

ENV CATALINA_HOME /opt/apache-tomcat
ENV PATH ${CATALINA_HOME}/bin:$PATH

RUN curl --silent --location --retry 3 \
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
	curl --silent --location --retry 3 --cacert /etc/ssl/certs/GlobalSign_Root_CA.pem \
	        https://www.openssl.org/source/openssl-"${OPENSSL_VERSION}".tar.gz \
        	| tar xz -C /tmp && \
        cd /tmp/openssl-"${OPENSSL_VERSION}" && \
                ./config --prefix=/usr && \
                make clean && make && make install && \
	curl --silent --location --retry 3 \
		http://archive.apache.org/dist/apr/apr-${APR_VERSION}.tar.gz \
		| tar xz -C /tmp && \
	cd /tmp/apr-${APR_VERSION} && \
		./configure && \
		make clean && make && make install && \
	curl --silent --location --retry 3 \
		http://archive.apache.org/dist/tomcat/tomcat-connectors/native/${TC_NATIVE_VERSION}/source/tomcat-native-${TC_NATIVE_VERSION}-src.tar.gz \
		| tar xz -C /tmp && \
	cd /tmp/tomcat-native-${TC_NATIVE_VERSION}-src/native && \
		./configure -with-apr=/usr/local/apr/ -with-ssl=/usr -with-java-home=${JAVA_HOME} -prefix=${CATALINA_HOME} && \
		make clean && make && make install && \
	apt-get remove --purge --auto-remove -y \
		gcc \
		libc6-dev \
		libssl-dev \
		libfile-dircompare-perl \
		make && \
	apt-get autoclean && apt-get --purge -y autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LD_LIBRARY_PATH "${LD_LIBRARY_PATH}:${CATALINA_HOME}/lib"

EXPOSE 8005 8080 8009 8443 45564 4000

WORKDIR ${CATALINA_HOME}

CMD ${CATALINA_HOME}/bin/catalina.sh run
