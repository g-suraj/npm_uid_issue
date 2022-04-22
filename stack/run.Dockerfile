FROM ubuntu:bionic

LABEL io.buildpacks.stack.id="io.buildpacks.stacks.bionic"

ENV CNB_USER_ID=1668
ENV CNB_GROUP_ID=1668
ENV CNB_STACK_ID="io.buildpacks.stacks.bionic"

RUN echo "debconf debconf/frontend select noninteractive" | debconf-set-selections && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get -y update && \
  apt-get -y upgrade && \
  apt-get -y install locales && \
  locale-gen en_US.UTF-8 && \
  update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 && \
  find /usr/share/doc/*/* ! -name copyright | xargs rm -rf && \
  rm -rf \
    /usr/share/man/* /usr/share/info/* \
    /usr/share/groff/* /usr/share/lintian/* /usr/share/linda/* \
    /var/lib/apt/lists/* /tmp/*

RUN groupadd cnbg --gid ${CNB_GROUP_ID} && useradd -m --gid ${CNB_GROUP_ID} --uid ${CNB_USER_ID} cnb
USER ${CNB_USER_ID}:${CNB_GROUP_ID}
