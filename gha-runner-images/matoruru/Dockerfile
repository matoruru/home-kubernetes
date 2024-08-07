FROM ghcr.io/actions/actions-runner:latest

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y jq

WORKDIR /home/runner
