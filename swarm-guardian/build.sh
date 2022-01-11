 #!/bin/bash
 docker build -f Dockerfile \
    -t neuroforgede/swarm-guardian:latest \
    -t neuroforgede/swarm-guardian:0.1 \
    .

docker push neuroforgede/swarm-guardian:latest
docker push neuroforgede/swarm-guardian:0.1