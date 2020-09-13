# nodetab

`nodetab` provides cron job functionality for Node.js applications. This image runs cron jobs based on given schedule and task command. The latest version of nodetab has Node.js v14.

## Usage 

The image expects 2 environment variables : `SCHEDULE` and `TASK`. `TASK` defines the command which should be run periodically. `SCHEDULE` defines when the task must be run. `SCHEDULE` has exactly the same time format with crontab. It must contain 5 sections defining *minute*, *hour*, *day of month*, *month*, *day of week*. Star notation and `/` can be used as well as any valid crontab time format.

The application or script code must be mounted to `/app`. All the tasks are run under `/app` directory in the container.

## Running with `docker run`

If you want to run any available bash command without any external script or code :

```
docker run -it --rm  -e SCHEDULE="* * * * *" -e TASK="node -v" uguraslan/nodetab
```

If you have an index.js file (or any JavaScript file) which should be run directly with `node` :

```
docker run -it --rm -v $PWD:/app -e SCHEDULE="* * * * *" -e TASK="node index.js" uguraslan/nodetab
```

If you have an app which can be run with `npm` commands : 

```
docker run -it --rm -v $PWD:/app -e SCHEDULE="* * * * *" -e TASK="npm start" uguraslan/nodetab
```

## Running with `docker-compose.yml`

You can use following sample docker compose file to run `nodetab` : 

```
version: '3.7'

services:
  cron:
    image: uguraslan/nodetab:latest
    environment:
      SCHEDULE: "* * * * *"
      TASK: "node index.js"
    volumes:
      - .:/app
```

## Extending as a new `Dockerfile`

If you want to create an docker image by adding your application/script code you can use following template. The default WORKDIR is `/app` directory.

```
FROM uguraslan/nodetab:latest

COPY . /app
```

## Notes :

- The task command must be run and exit after it finishes its job.