FROM python:2-alpine

ENV VERSION 2.11.0

WORKDIR /src
RUN apk add --update build-base libxml2 libxml2-dev libxslt libxslt-dev \
  swig openssl openssl-dev && rm -rf /var/cache/apk/*
RUN pip install lxml netaddr M2Crypto cherrypy mako requests bs4
RUN wget https://github.com/smicallef/spiderfoot/archive/v${VERSION}-final.tar.gz && \
  tar xzf v${VERSION}-final.tar.gz && \
  ls -lah && \
  rm v${VERSION}-final.tar.gz && \
  mv spiderfoot-${VERSION}-final spiderfoot
WORKDIR /src/spiderfoot
RUN pip install -r requirements.txt

EXPOSE 8080
ENTRYPOINT ["/src/spiderfoot/sf.py"]
CMD ["0.0.0.0:8080"]
