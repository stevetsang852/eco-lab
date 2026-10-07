# Client lab image

Two ways to supply the client you already have. This image never downloads it.

## A — bind mount (preferred)

```bash
export ECO_CLIENT_PATH=/absolute/path/to/your/eco
docker compose -f docker-compose.client.yml up --build
```

Browser: http://127.0.0.1:6080/vnc.html

`server.lst` must point at the host, not container localhost:

```text
host.docker.internal 17832
```

Login 17832, World 17831, Map 17833. Compose adds `host.docker.internal`.

## B — copy into the image

```bash
cp -a /absolute/path/to/your/eco/. docker/client-lab/client-src/
INSTALL_CLIENT=1 docker compose -f docker-compose.client.yml build
docker compose -f docker-compose.client.yml up
```

Build fails if `client-src/eco.exe` is missing. Do not commit that directory.
