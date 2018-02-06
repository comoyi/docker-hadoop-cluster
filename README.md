# docker-hadoop-cluster

## Step by step

### Build docker image

```bash
./build-image.sh
```

### Start docker container

```bash
./start-container.sh
```

### Get into container

```bash
docker exec -it hadoop-master bash
```

### Start hadoop

```bash
./start-all.sh
```

### Run word-count example

```bash
./word-count.sh
```

### Open browser

cluster [http://127.0.0.1:8088](http://127.0.0.1:8088)

dfs [http://127.0.0.1:9870](http://127.0.0.1:9870)