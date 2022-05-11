FROM python:3.9-alpine

EXPOSE 8080

# Official Arelle github repo
ENV GITHUB_ARELLE https://github.com/Arelle/Arelle.git


RUN apk add --update \
  build-base \
  libxml2-dev \
  libxslt-dev \
  git \
  && rm -rf /var/cache/apk/*

# Install pip
RUN pip3 install --upgrade pip

# Install Arelle dependencies
RUN pip3 install lxml numpy isodate regex openpyxl pyparsing six tornado matplotlib rdflib 
RUN pip3 install python-dateutil

# Make app directory
RUN mkdir app

# "cd" to app
WORKDIR app

# Pull from Arelle gh repo
RUN git clone --recursive $GITHUB_ARELLE . && git checkout 0baf5b2efd6717f4ddbea9e8712be9040a2604cf && python3 setup.py install

# Copy taxonomies and docker-setup.sh
COPY taxonomies /taxonomies/
COPY docker-setup.sh .

# Run docker-setup.sh script
ENTRYPOINT ["/bin/sh"]
CMD ["docker-setup.sh"]