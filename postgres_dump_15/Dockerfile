FROM postgres:15

RUN apt-get update && apt-get install -y curl bash python3 python3-pip

RUN groupadd -g 1000 user
RUN useradd -rm -d /home/user -s /bin/bash -u 1000 -g user user

USER user:user