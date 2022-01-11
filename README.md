# docker-swarm-tools

This repository contains useful docker-swarm-tools.

## swarm-guardian

[![neuroforgede/swarm-guardian](https://img.shields.io/docker/pulls/neuroforgede/swarm-guardian)](https://hub.docker.com/r/neuroforgede/swarm-guardian)

This Docker image is intended to be used in a multihost docker environment that uses
docker swarm for networking but still has non swarm docker containers attached to networks.
The default docker swarm restart policies dont work if a container fails to start because
of a network not being present. The swarm-guardian solves this issue.

## nginx-tcp-forward

[![neuroforgede/nginx-tcp-forward](https://img.shields.io/docker/pulls/neuroforgede/nginx-tcp-forward)](https://hub.docker.com/r/neuroforgede/nginx-tcp-forward)

This Docker image is intended to be used in a multihost docker environment with an overlay network.
While the docker swarm routing mesh would do the job for some deployments,
it won't work for regular containers that are attached to the network that
you might want to route to from a central ingress server.

Also for docker swarm services this image might be more useful
than published docker swarm ports. This is because docker swarm does not allow
to bind to ips and therefore any published port is available via the host from
any docker container.

Note: For Docker Swarm networks, make sure to use properly encrypted ones (including the ingress network!).