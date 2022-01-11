# swarm-guardian

[![neuroforgede/swarm-guardian](https://img.shields.io/docker/pulls/neuroforgede/swarm-guardian)](https://hub.docker.com/r/neuroforgede/swarm-guardian)

This Docker image is intended to be used in a multihost docker environment that uses
docker swarm for networking but still has non swarm docker containers attached to networks.
The default docker swarm restart policies dont work if a container fails to start because
of a network not being present. The swarm-guardian solves this issue.

## Environment variables

```
GUARDIAN_DOCKER_CLIENT_CREATE_FAILED_TIMEOUT = int(os.getenv('GUARDIAN_DOCKER_CLIENT_CREATE_FAILED_TIMEOUT', '10'))
GUARDIAN_DOCKER_CONTAINER_START_FAILED_TIMEOUT = int(os.getenv('GUARDIAN_DOCKER_CLIENT_CONTAINER_START_FAILED_TIMEOUT', '2'))
GUARDIAN_WATCHDOG_INTERVAL = int(os.getenv('GUARDIAN_WATCHDOG_INTERVAL', '5'))
```

## Usage Example (Ansible)

Simply create an instance of the swarm guardian on every one of your hosts that are part of the swarm and
have non swarm managed containers running on them.

```
- name: download docker image for docker swarm guardian
  docker_image:
    name: "{{ docker_swarm_guardian_docker_image | default('neuroforgede/swarm-guardian') }}"
    tag: "{{ docker_swarm_guardian_docker_tag | default('latestProduction') }}"
    force_source: yes
    source: pull

- name: "Create swarm guardian"
  docker_container:
    name: "{{ docker_swarm_guardian_container_name | default('swarm_guardian') }}"
    image: "{{ docker_swarm_guardian_docker_image | default('neuroforgede/swarm-guardian') }}:{{ docker_swarm_guardian_docker_tag | default('0.1') }}"
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock:ro"
    env:
      GUARDIAN_DOCKER_CLIENT_CREATE_FAILED_TIMEOUT: "10"
      GUARDIAN_DOCKER_CONTAINER_START_FAILED_TIMEOUT: "2"
      GUARDIAN_WATCHDOG_INTERVAL: "5"
    privileged: "{{ skipper_docker_privileged | default(False) | bool }}"
    recreate: true
    networks_cli_compatible: yes
    purge_networks: yes
    restart_policy: unless-stopped
    networks: []
```