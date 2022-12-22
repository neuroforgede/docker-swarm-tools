 #!/bin/bash
 docker build -f Dockerfile \
    -t neuroforgede/postgres_dump:14 \
    .

docker push neuroforgede/postgres_dump:14