# [2019] - [2021] © NeuroForge GmbH & Co. KG
import re
import docker
import time
import sys
import signal
import os
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('swarm_guardian')

GUARDIAN_DOCKER_CLIENT_CREATE_FAILED_TIMEOUT = int(os.getenv('GUARDIAN_DOCKER_CLIENT_CREATE_FAILED_TIMEOUT', '10'))
GUARDIAN_DOCKER_CONTAINER_START_FAILED_TIMEOUT = int(os.getenv('GUARDIAN_DOCKER_CLIENT_CONTAINER_START_FAILED_TIMEOUT', '2'))
GUARDIAN_WATCHDOG_INTERVAL = int(os.getenv('GUARDIAN_WATCHDOG_INTERVAL', '5'))

def signal_handler(signal, frame):
    logger.info(f'Got signal {signal}. Exiting...\n')
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)  


def network_not_found(container) -> bool:
    return container.attrs['State']['Status'] == 'exited' and container.attrs['State']['ExitCode'] != 0 and re.match('^network [a-zA-Z0-9]+ not found$', container.attrs['State']['Error'])

def attaching_to_network_failed(container) -> bool:
    return container.attrs['State']['Status'] == 'exited' and container.attrs['State']['ExitCode'] != 0 and re.match('^attaching to network failed.*$', container.attrs['State']['Error'])


while True:
    logger.info('checking containers if they need to be started...')

    try:
        try:
            CLIENT = docker.from_env()
        except:
            logger.exception('failed to instantiate docker client, retrying soon')
            time.sleep(GUARDIAN_DOCKER_CLIENT_CREATE_FAILED_TIMEOUT)
            continue
        
        once = False
        for cur_container in CLIENT.containers.list(all=True, filters={'status': 'exited'}):
            if network_not_found(cur_container) or attaching_to_network_failed(cur_container):
                once = True
                logger.info(f'found dead container {cur_container.name}')
                logger.info('starting it now...')
                try:
                    cur_container.start()
                except:
                    time.sleep(GUARDIAN_DOCKER_CONTAINER_START_FAILED_TIMEOUT)
                    logger.warning('failed to start container, trying next...')

        if not once:
            logger.info(f'nothing seems to be dead')
        
        time.sleep(GUARDIAN_WATCHDOG_INTERVAL)
    finally:
        if CLIENT is not None:
            try:
                CLIENT.close()
            except:
                logger.exception('failed to close client')