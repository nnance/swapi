FROM httpd:2.4

# Install base packages
RUN apt-get update && \
    apt-get -yq install \
        git \
        make \
        python-pip \
        python-dev \
        postgresql \
        libmemcached-dev \
        libpq-dev && \
    pip install mod_wsgi && \
    rm -rf /var/lib/apt/lists/*

ADD . /app
WORKDIR /app

RUN make install && \
    make build && \
    make load_data

CMD ["mod_wsgi-express", "start-server", "--port=80", "swapi/wsgi.py", "--user", "www-data", "--group", "www-data"]
