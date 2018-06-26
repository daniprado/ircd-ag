LABEL net.argallar.name="ircd-ag"
LABEL net.argallar.version="0.0.1"

FROM centos:latest

RUN rpm --rebuilddb \
&& rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7 \
&& yum -y install --setopt=tsflags=nodocs --disableplugin=fastestmirror \
  epel-release autoconf automake libtool openssl openssl-devel sudo tar wget git gcc gettext zlib-devel libgcrypt-devel libwebp-devel \
  libpurple-devel purple-skypeweb pidgin-skypeweb bitlbee bitlbee-devel znc

RUN useradd unrealircd \
&& sudo -H -u unrealircd sh -c 'wget --no-check-certificate --trust-server-names -O ~/unrealircd.tar.gz https://www.unrealircd.org/downloads/unrealircd-latest.tar.gz' \
&& sudo -H -u unrealircd sh -c 'tar -xzC ~/ -f ~/unrealircd.tar.gz' \
&& sudo -H -u unrealircd sh -c 'cd "$(dirname "$(find ~ -type f -name Config | head -1)")" && ./Config && make && make install'

RUN cd && git clone --recursive https://github.com/majn/telegram-purple \
&& cd telegram-purple && ./configure --disable-gcrypt && make && make install

RUN cd && git clone https://github.com/kensanata/bitlbee-mastodon.git \
&& cd bitlbee-mastodon && ./autogen.sh && ./configure && make && make install

RUN cd && git clone https://github.com/jgeboski/bitlbee-steam.git \
&& cd bitlbee-steam && ./autogen.sh && make && make install

RUN yum clean all

RUN cp -Rf /home/unrealircd/unrealircd/conf /home/unrealircd/unrealircd/conf.bk
RUN cp -Rf /etc/bitlbee /etc/bitlbee.bk
RUN cp -Rf /var/lib/bitlbee /var/lib/bitlbee.bk

COPY files/start.sh /usr/local/bin
COPY files/run.sh /usr/local/bin
COPY files/znc.defaults /etc

EXPOSE 7667
VOLUME ["/home/unrealircd/unrealircd/conf", "/home/unrealircd/unrealircd/logs", "/etc/bitlbee", "/var/lib/bitlbee", "/var/lib/znc/"]
ENTRYPOINT ["start.sh"]
CMD ["run.sh"]

