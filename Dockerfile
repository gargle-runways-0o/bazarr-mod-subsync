FROM scratch

WORKDIR /root-layer

COPY root/ /root-layer

RUN RUN chmod -R +x /root-layer

# copy local files
COPY /root-layer /
