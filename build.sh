 #!/bin/bash
 docker build -f Dockerfile \
    -t ancieque/nginx-tcp-forward:latest \
    -t ancieque/nginx-tcp-forward:0.1 \
    .

docker push ancieque/nginx-tcp-forward:latest
docker push ancieque/nginx-tcp-forward:0.1