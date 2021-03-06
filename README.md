# docker-hadoop-cluster

## Step by step

### Get repository

```bash
git clone https://github.com/comoyi/docker-hadoop-cluster.git
```

### Enter the directory

```bash
cd docker-hadoop-cluster
```

### Build docker image

```bash
./build-image.sh
```

### Run docker container

```bash
./run-container.sh
```

### Get into container

```bash
docker exec -it hadoop-master bash
```

or

```bash
./init-tmux-session.sh
```

### Start hadoop

```bash
./start-all.sh
```

### Run word-count example

```bash
./word-count.sh
```

### Open the browser on the host (not in docker)

```bash
./open-browser.sh
```

cluster [http://127.0.0.1:8088](http://127.0.0.1:8088)

dfs [http://127.0.0.1:9870](http://127.0.0.1:9870)

job [http://127.0.0.1:19888](http://127.0.0.1:19888)

## Other

### Start docker container

```bash
./start-container.sh
```

### Stop docker container

```bash
./stop-container.sh
```
