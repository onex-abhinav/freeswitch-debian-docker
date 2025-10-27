FROM debian:12

ARG SIGNALWIRE_TOKEN
ENV DEBIAN_FRONTEND=noninteractive

# Install base tools
RUN apt-get update && \
    apt-get install -y gnupg2 wget curl lsb-release ca-certificates

# Set up SignalWire FreeSWITCH repo using token
RUN wget --http-user=signalwire --http-password=${SIGNALWIRE_TOKEN} \
    -O /usr/share/keyrings/signalwire-freeswitch-repo.gpg \
    https://freeswitch.signalwire.com/repo/deb/debian-release/signalwire-freeswitch-repo.gpg && \
    echo "machine freeswitch.signalwire.com login signalwire password ${SIGNALWIRE_TOKEN}" > /etc/apt/auth.conf && \
    chmod 600 /etc/apt/auth.conf && \
    echo "deb [signed-by=/usr/share/keyrings/signalwire-freeswitch-repo.gpg] https://freeswitch.signalwire.com/repo/deb/debian-release/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/freeswitch.list && \
    echo "deb-src [signed-by=/usr/share/keyrings/signalwire-freeswitch-repo.gpg] https://freeswitch.signalwire.com/repo/deb/debian-release/ $(lsb_release -sc) main" >> /etc/apt/sources.list.d/freeswitch.list

# Install FreeSWITCH and tools
RUN apt-get update && \
    apt-get install -y freeswitch-meta-all freeswitch-mod-amqp sngrep && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set entrypoint
CMD ["/usr/bin/freeswitch", "-nonat", "-nf"]
