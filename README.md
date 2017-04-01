# wildfly-docker

## Overview

This docker image contains [WildFly](https://wildfly.org/).

## Entrypoint Scripts

### wildfly

The embedded entrypoint script is located at `/etc/entrypoint.d/10wildfly` and performs the following actions:

1. A new wildfly configuration is generated using the following environment variables:

 | Variable | Default Value | Description |
 | ---------| ------------- | ----------- |
 | WILDFLY_PASSWORD | _random_ | The wildflly `admin` password. |

## Standard Configuration

### Container Layout

```
/
├─ etc/
│  └─ entrypoint.d/
│     └─ wildfly
├─ root/
│  └─ wildfly_password
└─ usr/
   └─ share/
      └─ wildfly/
```

### Exposed Ports

Note: The Web Managment Console port (`9990`) is not automatically exposed for security reasons.

* `8080/tcp` - The default port for deployed web applications.
* `8443/tcp` - SSL-encrypted connection between deployed web applications and clients.

### Volumes

None.

## Development

[Source Control](https://github.com/crashvb/wildfly-docker)

