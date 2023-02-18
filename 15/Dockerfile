FROM crashvb/supervisord:202302172130@sha256:c3ca0e25621af7c6bc594a0469d1ed763b4868f8fc5ceabaac384bd4c2496834
ARG org_opencontainers_image_created=undefined
ARG org_opencontainers_image_revision=undefined
LABEL \
	org.opencontainers.image.authors="Richard Davis <crashvb@gmail.com>" \
	org.opencontainers.image.base.digest="sha256:c3ca0e25621af7c6bc594a0469d1ed763b4868f8fc5ceabaac384bd4c2496834" \
	org.opencontainers.image.base.name="crashvb/supervisord:202302172130" \
	org.opencontainers.image.created="${org_opencontainers_image_created}" \
	org.opencontainers.image.description="Image containing wildfly." \
	org.opencontainers.image.licenses="Apache-2.0" \
	org.opencontainers.image.source="https://github.com/crashvb/wildfly-docker" \
	org.opencontainers.image.revision="${org_opencontainers_image_revision}" \
	org.opencontainers.image.title="crashvb/wildfly" \
	org.opencontainers.image.url="https://github.com/crashvb/wildfly-docker"

# Install packages, download files ...
ENV WILDFLY_HOME=/usr/share/wildfly WILDFLY_VERSION=15.0.1.Final
ENV JBOSS_HOME=${WILDFLY_HOME}
# Note: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199
# hadolint ignore=DL4006
RUN mkdir --parents ${WILDFLY_HOME} /usr/share/man/man1 && \
	docker-apt openjdk-11-jdk-headless && \
	wget --quiet --output-document=- http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz | \
	tar --directory=${WILDFLY_HOME} --extract --gzip --strip-components=1

# Configure: wildfly
ENV LAUNCH_JBOSS_IN_BACKGROUND=true
RUN useradd --comment="Wildfly Daemon" --home=${WILDFLY_HOME} --shell=/bin/bash wildfly && \
	chown --recursive wildfly:wildfly ${WILDFLY_HOME}

# Configure: supervisor
COPY supervisord.wildfly.conf /etc/supervisor/conf.d/wildfly.conf

# Configure: entrypoint
COPY entrypoint.wildfly /etc/entrypoint.d/10wildfly

EXPOSE 8080/tcp 8443/tcp
