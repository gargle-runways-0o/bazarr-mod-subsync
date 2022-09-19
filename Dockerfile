## Buildstage ##
FROM ghcr.io/linuxserver/baseimage-alpine:3.14 as buildstage

## Download dependencies ##
RUN apk add --no-cache \
	curl \
	git && \
	mkdir -p /root-layer/build && \
	cd /root-layer/build && \
	git clone https://github.com/cmusphinx/sphinxbase.git && \
	git clone https://github.com/cmusphinx/pocketsphinx.git && \
	git clone https://github.com/sc0ty/subsync.git && \
	curl -O https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz && \
	tar xf ffmpeg-release-amd64-static.tar.xz --directory ffmpeg/ && \
	rm ffmpeg-release-amd64-static.tar.xz
	
# add local files
COPY root/ /root-layer/
	
## Single layer deployed image ##
FROM scratch

# Add files from buildstage
COPY --from=buildstage /root-layer/ /
