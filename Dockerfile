FROM resin/rpi-raspbian:jessie

RUN  apt-get update \
  && apt-get install git-core build-essential wget cdbs debhelper libusb-1.0-0-dev libsystemd-daemon-dev autotools-dev autoconf automake libtool pkg-config dh-systemd
#libpthsem-dev libpthsem20

RUN apt-get install libev-dev

RUN git clone https://github.com/knxd/knxd.git
RUN cd knxd \
 && dpkg-buildpackage -b -uc

RUN dpkg -i knxd_*.deb knxd-tools_*.deb

EXPOSE 6720

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["knxd"]
