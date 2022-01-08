# nginx-tcp-forward

[![ancieque/nginx-tcp-forward](https://img.shields.io/docker/pulls/ancieque/nginx-tcp-forward)](https://hub.docker.com/r/ancieque/nginx-tcp-forward)

## Usage (Ansible example)

```
- name: download docker image ancieque/nginx-tcp-forward
  docker_image:
    name: "ancieque/nginx-tcp-forward"
    tag: "0.1"
    force_source: yes
    source: pull

- name: "create nginx tcp proxy"
  docker_container:
    name: "{{ nginx_tcp_forward_container_name }}"
    image: "ancieque/nginx-tcp-forward:0.1"
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