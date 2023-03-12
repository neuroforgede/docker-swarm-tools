 #!/bin/bash
 docker build -f Dockerfile \
    -t neuroforgede/mariadb_dump:latest \
    -t neuroforgede/mariadb_dump:10.11 \
    .

docker push neuroforgede/mariadb_dump:latest
docker push neuroforgede/mariadb_dump:10.11