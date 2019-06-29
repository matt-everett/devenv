FROM ubuntu:19.04

RUN apt-get update \
    && apt-get install -y bash-completion git subversion wget curl vim dnsutils jq \
        build-essential zlib1g-dev libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev

COPY init/* /root/
COPY install/* /root/install/
RUN /root/install/tools.sh
#RUN /root/install/pyenv.sh

#RUN kubectl version
#RUN helm version

COPY tools/* /usr/local/bin/

COPY sleep-loop /usr/local/bin/
ENTRYPOINT [ "/usr/local/bin/sleep-loop" ]
