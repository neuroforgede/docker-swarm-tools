FROM clickhouse/clickhouse-server:22.5.3.21

RUN apt-get update && apt-get install -y curl bash

RUN groupadd -g 1000 user
RUN useradd -rm -d /home/user -s /bin/bash -u 1000 -g user user

USER user:user