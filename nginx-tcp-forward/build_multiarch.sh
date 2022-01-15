docker buildx build \
--push \
--platform linux/arm/v7,linux/arm64/v8,linux/amd64 \
--tag neuroforgede/nginx-tcp-forward:latest \
--tag neuroforgede/nginx-tcp-forward:0.1 \
.