# jenkins-docker
Setup docker containers as Jenkins slaves

Tips:
1. How access docker api from within container?

running container with -v option to share socket.

docker run -v /var/run/docker.sock:/var/run/dockerhost/docker.sock  --name inception -i -t centos /bin/bash`
Now, we can access docker api of host from within docker.
Yes, -H options enables to switch socket file.

bash-4.2# docker -H unix:///var/run/dockerhost/docker.sock ps
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
567a67857236        centos:latest       bin/bash            About a minute ago   Up About a minute                       inception
