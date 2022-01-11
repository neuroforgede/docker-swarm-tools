 #!/bin/bash
 docker build -f Dockerfile \
    -t neuroforgede/nginx-tcp-forward:latest \
    -t neuroforgede/nginx-tcp-forward:0.1 \
    .

docker push neuroforgede/nginx-tcp-forward:latest
docker push neuroforgede/nginx-tcp-forward:0.1