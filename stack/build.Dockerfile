# Adapted from https://github.com/paketo-buildpacks/stacks/tree/main/bionic
# Adapted from https://github.com/paketo-buildpacks/stacks/tree/main/bionic
FROM ubuntu:bionic

LABEL io.buildpacks.stack.id="io.buildpacks.stacks.bionic"

ENV CNB_USER_ID=1667
ENV CNB_GROUP_ID=1668
ENV CNB_STACK_ID="io.buildpacks.stacks.bionic"

RUN echo "debconf debconf/frontend select noninteractive" | debconf-set-selections && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get -y update && \
  apt-get -y upgrade && \
  apt-get -y install locales git curl && \
  locale-gen en_US.UTF-8 && \
  update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 && \
  rm -rf /var/lib/apt/lists/* /tmp/*

RUN for path in /workspace /workspace/source-ws /workspace/source; do git config --system --add safe.directory "${path}"; done

RUN curl -sSfL -o /usr/local/bin/yj https://github.com/sclevine/yj/releases/latest/download/yj-linux-amd64 \
  && chmod +x /usr/local/bin/yj

RUN groupadd cnbg --gid ${CNB_GROUP_ID} && useradd -m --gid ${CNB_GROUP_ID} --uid ${CNB_USER_ID} cnb
