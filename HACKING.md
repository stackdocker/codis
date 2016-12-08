## Content

Build docker image for production

### Build

For example:

    [tangfx@localhost codis]$ docker build --no-cache --build-arg=golang_dist_server=http://10.64.33.1:48080 --build-arg=golang_dist_path=work -t tangfeixiong/codis:v3.1 -f hack/Dockerfile.release3%2E1.go1%2E6%2E2%2Elinux-amd64%2Etar%2Egz.debian%3Ajessie  .

Or via _Makefile_

    [tangfx@localhost codis]$ make hack

### Image

Default _Dockerfile_ __CMD__

    CMD ["/opt/bin/redis-server"]

Preview

    [tangfx@localhost codis]$ docker images tangfeixiong/codis
    REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
    tangfeixiong/codis   v3.1                dd71353ce394        8 minutes ago       411.6 MB
