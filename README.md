# nginx-tcp-forward

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
## Usage (Ansible example)

```
- name: download docker image neuroforgede/nginx-tcp-forward
  docker_image:
    name: "neuroforgede/nginx-tcp-forward"
    tag: "0.1"
    force_source: yes
    source: pull

- name: "create nginx tcp proxy"
  docker_container:
    name: "{{ nginx_tcp_forward_container_name }}"
    image: "neuroforgede/nginx-tcp-forward:0.1"
    recreate: true
    restart_policy: unless-stopped
    env:
      WORKER_CONNECTIONS: "768"
      DNS_RESOLVER: "127.0.0.11"
      DNS_RESOLVER_VALID: "10s"
      TCP_UPSTREAM: "{{ nginx_tcp_forward_upstream }}"
    ports:
      - "127.0.0.1:{{ nginx_tcp_forward_port }}:12345"
    privileged: "{{ docker_privileged | default(False) | bool }}"
    purge_networks: true
    networks_cli_compatible: yes
    networks:
      - name: "{{ nginx_tcp_forward_network }}"
        aliases: []
```