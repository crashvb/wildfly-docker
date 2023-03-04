FROM crashvb/supervisord:202303031721@sha256:6ff97eeb4fbabda4238c8182076fdbd8302f4df15174216c8f9483f70f163b68
ARG org_opencontainers_image_created=undefined
ARG org_opencontainers_image_revision=undefined
LABEL \
	org.opencontainers.image.authors="Richard Davis <crashvb@gmail.com>" \
	org.opencontainers.image.base.digest="sha256:6ff97eeb4fbabda4238c8182076fdbd8302f4df15174216c8f9483f70f163b68" \
	org.opencontainers.image.base.name="crashvb/supervisord:202303031721" \
	org.opencontainers.image.created="${org_opencontainers_image_created}" \
	org.opencontainers.image.description="Image containing wildfly." \
	org.opencontainers.image.licenses="Apache-2.0" \
	org.opencontainers.image.source="https://github.com/crashvb/wildfly-docker" \
	org.opencontainers.image.revision="${org_opencontainers_image_revision}" \
	org.opencontainers.image.title="crashvb/wildfly" \
	org.opencontainers.image.url="https://github.com/crashvb/wildfly-docker"

# Install packages, download files ...
ENV WILDFLY_HOME=/usr/share/wildfly WILDFLY_VERSION=27.0.1.Final
ENV JBOSS_HOME=${WILDFLY_HOME}
# Note: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199
# hadolint ignore=DL4006
RUN mkdir --parents ${WILDFLY_HOME} /usr/share/man/man1 && \
	docker-apt openjdk-11-jdk-headless && \
	wget --quiet --output-document=- https://github.com/wildfly/wildfly/releases/download/${WILDFLY_VERSION}/wildfly-${WILDFLY_VERSION}.tar.gz | \
	tar --directory=${WILDFLY_HOME} --extract --gzip --strip-components=1

# Configure: wildfly
ENV LAUNCH_JBOSS_IN_BACKGROUND=true
RUN useradd --comment="Wildfly Daemon" --home=${WILDFLY_HOME} --shell=/bin/bash wildfly && \
	chown --recursive wildfly:wildfly ${WILDFLY_HOME}

# Configure: profile
RUN echo "export JBOSS_HOME=${JBOSS_HOME}\nexport WILDFLY_HOME=${WILDFLY_HOME}" > /etc/profile.d/wildfly.sh && \
	chmod 0755 /etc/profile.d/wildfly.sh

# Configure: supervisor
COPY supervisord.wildfly.conf /etc/supervisor/conf.d/wildfly.conf

# Configure: entrypoint
COPY entrypoint.wildfly /etc/entrypoint.d/wildfly

# Configure: healthcheck
COPY healthcheck.wildfly /etc/healthcheck.d/wildfly

EXPOSE 8080/tcp 8443/tcp
