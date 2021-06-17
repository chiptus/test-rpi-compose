FROM alpine:latest

COPY ./dist /app

WORKDIR /app

ENTRYPOINT ["/app/docker", "--config", "/app/.docker", "compose", "up"]
