# Pull base image.
FROM python:2

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends git ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD .pypirc /root/
ADD pip.conf /root/.pip/

# upgrade pip version to latest
RUN pip install --upgrade pip

ADD pypi-requirements.txt /uploader/
RUN pip install --process-dependency-links -r /uploader/pypi-requirements.txt && rm -rf /uploader/pypi-requirements.txt

ADD docker-entrypoint.sh /uploader/
RUN chmod +x /uploader/docker-entrypoint.sh
CMD ["/uploader/docker-entrypoint.sh"]