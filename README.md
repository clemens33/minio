### Simple setup for minio, minio console and minio client using docker compose 

#### Run from single command (e.g. for development)

- requires [docker compose](https://docs.docker.com/compose/)
- clone/fork this repo and cd into it
- start using the following command (copy all and run) - change password/ports as required - command expects a folder under "~/data/minio" where minio will be persisted - change to your peristance location
```
export MINIO_STORAGE_LOCATION=~/data/minio && \
export MINIO_PORT=9001 && \
export MINIO_CONSOLE_PORT=9091 && \
export MINIO_ROOT_USER=minio && \
export MINIO_ROOT_PASSWORD=minio123 && \
\
if [ ! -d "./data" ]; then ln -s $MINIO_STORAGE_LOCATION ./data; fi && \
\
docker-compose pull && \
docker-compose up --remove-orphans -d && \
\
alias mc='docker exec -it minio-client mc'
```
- the above command sets an alias command "mc" which can be used to adminstrate/create buckets on the minio instance running within docker - refer to [minio client docu](https://docs.min.io/docs/minio-client-complete-guide.html)

- (optional) if you want to use minio console - create console user and policy
```
export MINIO_CONSOLE_USER=console && \
export MINIO_CONSOLE_PASSWORD=console123 && \
\
mc admin user add minio/ $MINIO_CONSOLE_USER $MINIO_CONSOLE_PASSWORD && \
mc admin policy add minio/ consoleAdmin /root/.mc/admin.json && \
mc admin policy set minio consoleAdmin user=$MINIO_CONSOLE_USER
```
- access using defined ports - e.g. http://localhost:9001 for minio and http://localhost:9091 for minio console (using console user/password)

#### (optional) Simple setup using cron

- define a simple bash script - refer to [sample](.start.sh)
- add the following line to cron (crontab -e) - starts docker containers serving minio 30s after reboot

```
@reboot (sleep 30s; ~/docker/minio/start.sh)&
```

#### Comments

- if you find issues or have suggestions to improve the basic and minimalistic setup please let me know