 #!/bin/bash
 docker build -f Dockerfile \
    -t neuroforgede/clickouse_dump:latest \
    -t neuroforgede/clickhouse_dump:22.5.3.21 \
    .

docker push neuroforgede/clickhouse_dump:latest
docker push neuroforgede/clickhouse_dump:22.5.3.21