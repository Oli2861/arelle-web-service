FROM python:3.5-alpine

ENV GITHUB_ARELLE https://github.com/Arelle/Arelle.git

EXPOSE 8080

RUN apk add --update \
  build-base \
  libxml2-dev \
  libxslt-dev \
  git \
  && rm -rf /var/cache/apk/*

RUN pip3 install --upgrade pip

RUN pip3 install lxml openPyXL rdflib pg8000

RUN mkdir app

WORKDIR app

RUN git clone --recursive $GITHUB_ARELLE . && git checkout 4211c6222626309e4167888059c4f97e8b579b1c && python3 setup.py install

COPY taxonomies .
COPY report .
COPY docker-setup.sh .
RUN unzip AppropriationsAccountPackage.zip -q
RUN unzip FinancialAccountPackage.zip -q

ENTRYPOINT ["/bin/sh"]

CMD ["docker-setup.sh"]
