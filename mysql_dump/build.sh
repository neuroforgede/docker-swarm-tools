 #!/bin/bash
 docker build -f Dockerfile \
    -t neuroforgede/mysql_dump:latest \
    -t neuroforgede/mysql_dump:8.0 \
    .

docker push neuroforgede/mysql_dump:latest
docker push neuroforgede/mysql_dump:8.0