FROM ubuntu:16.04

#clean repo
RUN apt-get clean
#add i386 arch
RUN dpkg --add-architecture i386
#refresh repo
RUN apt-get update
#install git
RUN apt-get install -y git
#create dir /pmp
RUN mkdir /pmp

#clone libreELEC repo
RUN git clone https://github.com/plexinc/LibreELEC.tv /pmp
#change directory to /pmp
WORKDIR /pmp
#checkout dist-master repo
RUN git checkout dist-master

#disable ffserver as it's not in latest ffmpeg
RUN grep -rnwl /pmp/ -e '--disable-ffserver' |xargs sed -i '/--disable-ffserver \\/d'

#install dependencies
RUN apt-get install -y build-essential wget bc gawk gperf \
zip unzip lzop xsltproc openjdk-9-jre-headless libncurses5-dev \
texi2html libexpat1 gcc-multilib libexpat1-dev:i386 libfreetype6-dev:i386 \
libexpat1-dev libfreetype6-dev fontconfig:i386 wget bc gawk gperf zip unzip \
lzop xsltproc openjdk-9-jre-headless libncurses5-dev texi2html libexpat1 g++-multilib \
file libauthen-sasl-perl libcommon-sense-perl libencode-locale-perl \
libfile-listing-perl libfont-afm-perl libfontenc1 libhtml-form-perl \
libhtml-format-perl libhtml-parser-perl libhtml-tagset-perl \
libhtml-tree-perl libhttp-cookies-perl libhttp-daemon-perl libhttp-date-perl \
libhttp-message-perl libhttp-negotiate-perl libio-html-perl \
libio-socket-ssl-perl libjson-perl libjson-xs-perl liblwp-mediatypes-perl \
liblwp-protocol-https-perl libmagic1 libmailtools-perl libnet-http-perl \
libnet-smtp-ssl-perl libnet-ssleay-perl libpython-all-dev libpython-dev \
libpython-stdlib libpython2.7 libpython2.7-dev libpython2.7-minimal \
libpython2.7-stdlib libtimedate-perl libtypes-serialiser-perl liburi-perl \
libwww-perl libwww-robotrules-perl libxfont1 libxml-libxml-perl \
libxml-namespacesupport-perl libxml-parser-perl libxml-sax-base-perl \
libxml-sax-expat-perl libxml-sax-perl mime-support patchutils python \
python-all python-all-dev python-dev python-minimal python-pip \
python-pip-whl python-pkg-resources python-setuptools python-wheel python2.7 \
python2.7-dev python2.7-minimal tex-common texinfo xfonts-encodings \
xfonts-utils sudo curl help2man apt-utils 

#add ssh key
RUN mkdir /root/.ssh
RUN ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
RUN chmod 700 /root/.ssh
ADD ./.ssh/id_rsa /root/.ssh/id_rsa
RUN chmod 600 ~/.ssh/id_rsa 

#build pmp
RUN DISTRO=PlexMediaPlayer \
PROJECT=RPi2 \
ARCH=arm \
PMP_REPO=plex-media-player \
PMP_BRANCH=master \
make image
