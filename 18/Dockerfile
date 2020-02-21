FROM crashvb/supervisord:202002211640
LABEL maintainer "Richard Davis <crashvb@gmail.com>"

# Install packages, download files ...
ENV WILDFLY_HOME=/usr/share/wildfly WILDFLY_VERSION=18.0.1.Final
# Note: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199
RUN mkdir --parents ${WILDFLY_HOME} /usr/share/man/man1 && \
	docker-apt openjdk-11-jdk-headless && \
	wget --quiet --output-document=- http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz | \
	tar --directory=${WILDFLY_HOME} --extract --gzip --strip-components=1

# Configure: wildfly
ENV LAUNCH_JBOSS_IN_BACKGROUND=true
RUN useradd --comment="Wildfly Daemon" --home=${WILDFLY_HOME} --shell=/bin/bash wildfly && \
	chown --recursive wildfly:wildfly ${WILDFLY_HOME}

# Configure: supervisor
ADD supervisord.wildfly.conf /etc/supervisor/conf.d/wildfly.conf

# Configure: entrypoint
ADD entrypoint.wildfly /etc/entrypoint.d/10wildfly

EXPOSE 8080/tcp 8443/tcp
