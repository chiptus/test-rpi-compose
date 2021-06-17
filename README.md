# Test docker compose on rpi:

## run using repository

1. Download docker and the plugin with `./docker-download.sh linux aarch64 20.10.7`

This will download docker into `./dist` and the compose plugin into `./dist/.docker/cli-plugins`

2. this should work:
   a. `./dist/docker --config ./dist/.docker compose up` or

   b. run and build image:

```
docker build -t test-rpi-compose .
docker run -v /var/run/docker.sock:/var/run/docker.sock:z test-rpi-compose
```

## run from dockerhub

```
docker run -v /var/run/docker.sock:/var/run/docker.sock:z chiptus/test-rpi-compose
```
