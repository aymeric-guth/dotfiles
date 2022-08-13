#!/bin/sh

_cleanup_docker() {
    ### Docker
    yes | docker container prune;
    yes | docker image prune -a;
    yes | docker network prune;
    yes | docker volume prune;
    yes | docker builder prune;
}
