FROM crashvb/supervisord:latest
MAINTAINER Richard Davis <crashvb@gmail.com>

# Install packages, download files ...
ENV WILDFLY_HOME=/usr/share/wildfly WILDFLY_VERSION=10.1.0.Final
RUN docker-apt default-jdk-headless && \
	mkdir --parents ${WILDFLY_HOME} && \
	wget --quiet --output-document=- http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz | \
	tar --directory=${WILDFLY_HOME} --extract --gzip --strip-components=1

# Configure: supervisor
ADD supervisord.wildfly.conf /etc/supervisor/conf.d/wildfly.conf

# Configure: entrypoint
ADD entrypoint.wildfly /etc/entrypoint.d/10wildfly

EXPOSE 8080/tcp 8443/tcp 9990/tcp
