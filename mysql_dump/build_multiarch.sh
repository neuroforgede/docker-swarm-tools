docker buildx build \
--push \
--platform linux/arm/v7,linux/arm64/v8,linux/amd64 \
--tag neuroforgede/mysql_dump:latest \
--tag neuroforgede/mysql_dump:0.1 \
.