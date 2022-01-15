docker buildx build \
--push \
--platform linux/arm/v7,linux/arm64/v8,linux/amd64 \
--tag neuroforgede/swarm-guardian:latest \
--tag neuroforgede/swarm-guardian:0.1 \
.