#!/usr/bin/with-contenv bash

if [ ! -f /usr/bin/subsync ]; then
	apk update && \
    apk add --no-cache git wget tar && \
	mkdir /build && \
	cd /build && \
	wget https://sourceforge.net/projects/cmusphinx/files/sphinxbase/5prealpha/sphinxbase-5prealpha.tar.gz/download -O sphinxbase.tar.gz && \
	tar -xzf sphinxbase.tar.gz && \
	rm sphinxbase.tar.gz && \
	mv sphinxbase-5prealpha sphinxbase && \
	wget https://sourceforge.net/projects/cmusphinx/files/pocketsphinx/5prealpha/pocketsphinx-5prealpha.tar.gz/download -O pocketsphinx.tar.gz && \
	tar -xzf pocketsphinx.tar.gz && \
	rm pocketsphinx.tar.gz && \
	mv pocketsphinx-5prealpha pocketsphinx && \
	git clone https://github.com/sc0ty/subsync.git && \
	wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz && \
	tar -xf ffmpeg-release-amd64-static.tar.xz && \
	rm ffmpeg-release-amd64-static.tar.xz && \
	mv ffmpeg-5.1.1-amd64-static ffmpeg
	
	apk add --no-cache gcc automake autoconf libtool bison swig python3-dev pulseaudio-dev
	
	apk add --no-cache make g++ libffi-dev openssl-dev libgcc ffmpeg-dev py3-pybind11-dev alsa-lib-dev build-base

	python3 -m ensurepip
	rm -r /usr/lib/python*/ensurepip
	pip3 install --upgrade pip setuptools
	rm -r /root/.cache

	cd /build/sphinxbase
	./configure --enable-fixed
	make
	make install

	export LD_LIBRARY_PATH=/usr/local/lib
	export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

	cd /build/pocketsphinx
	./configure
	make
	make install

	export FFMPEG_DIR=/build/ffmpeg
	export SPHINXBASE_DIR=/build/sphinxbase
	export POCKETSPHINX_DIR=/build/pocketsphinx
	export USE_PKG_CONFIG=no

	pip3 install /build/subsync/
	
	rm -rf /build
fi