FROM summerwind/actions-runner-dind

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y jq

USER runner

