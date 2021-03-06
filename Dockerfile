FROM resin/raspberry-pi3-node

# install required packages
RUN apt-get update && apt-get install -yq --no-install-recommends \
    bluez \
    bluez-firmware && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR usr/src/app

COPY package.json ./
RUN JOBS=MAX npm i --production

COPY . ./

# enable systemd init system in the container so it doesn't restart
ENV INITSYSTEM on

# Run start.sh when the container starts up on the device
CMD ["bash", "start.sh"]
