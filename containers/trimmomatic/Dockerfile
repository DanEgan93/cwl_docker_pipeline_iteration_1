# A dockerfile to generate a dockerised version of Trimmomatic

# processes within all containers should NOT be run as root
# TODO create user to run commands in containers
# need to add the adapater sequences from trimmoatic/adapters/nextera into a loction accessible to the program inside the container

## Base image
FROM alpine:3.7

ENV HOME /root

RUN apk --update add openjdk7-jre \
	&& apk add wget \
	&& wget -O /tmp/trimmomatic-0.38.zip www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.38.zip \
	&& mkdir /usr/local/pipeline \
	&& unzip /tmp/trimmomatic-0.38.zip -d /usr/local/pipeline \
	&& chmod 755 /usr/local/pipeline/

 
RUN addgroup -S pipe \
	&& adduser -D pipeman -G pipe

USER pipeman


MAINTAINER Daniel Egan daniel.egan1@nhs.net

CMD ["/bin/sh"]

