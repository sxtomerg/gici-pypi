# Pull base image.
FROM python:2

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends git ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD .pypirc /root/
ADD pip.conf /root/.pip/

# upgrade pip version to latest
RUN pip install --upgrade pip && \
	export PATH=$PATH:/usr/local/bin

ADD pypi-requirements.txt /app/
RUN pip install --process-dependency-links -r /app/pypi-requirements.txt && rm -rf /app/pypi-requirements.txt

ADD docker-entrypoint.sh /uploader/
RUN chmod +x /uploader/docker-entrypoint.sh
CMD ["/uploader/docker-entrypoint.sh"]