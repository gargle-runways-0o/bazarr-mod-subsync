## Buildstage ##
FROM ghcr.io/linuxserver/baseimage-alpine:3.14 as buildstage

## Download dependencies ##
RUN apk add --no-cache \
	git \
	wget \
	tar && \
	mkdir -p /root-layer/build && \
	cd /root-layer/build && \
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
	mv ffmpeg-release-amd64-static ffmpeg
	chown +x /root-layer/build
	
# add local files
COPY root/ /root-layer/
	
## Single layer deployed image ##
FROM scratch

# Add files from buildstage
COPY --from=buildstage /root-layer/ /
