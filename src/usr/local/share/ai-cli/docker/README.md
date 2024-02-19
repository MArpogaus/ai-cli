# How to use proxy to assign domain names for services

Look at `proxy_demo` compose file.

Execute it for example with (adjust exported variables accordingly)

```
export DOCKER_USER=$(id -u):$(id -g)
export URLNAME=ai4grids.ei.htwg-konstanz.de

docker compose -f proxy_demo.docker-compose.yaml up
```