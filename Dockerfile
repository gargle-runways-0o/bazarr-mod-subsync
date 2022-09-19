FROM scratch

RUN mkdir /root-layer

COPY root/ /root-layer/

RUN chmod -R +x /root-layer

# copy local files
COPY /root-layer/ /
