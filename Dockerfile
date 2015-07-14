# sshd
#
# VERSION               0.0.2

#FROM selenium/standalone-firefox:2.46.0
FROM ning/ubuntu-browsers-jdk:latest
MAINTAINER Ning Zou <nzou@splunk.com>

USER root




#====================================
# Scripts to run Selenium Standalone
#====================================
COPY entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh


#====================================
# Scripts to setup splunk and test
#====================================
COPY splunk.tgz /tmp/splunk.tgz
WORKDIR /tmp
RUN tar zxvf splunk.tgz
COPY splunkqa.tgz /tmp/splunkqa.tgz
RUN tar zxvf splunkqa.tgz
VOLUME /splunkdb
RUN echo "SPLUNK_DB=/splunkdb" >> splunk/etc/splunk-launch.conf.default
# Clean up useless tgz package
RUN rm -rf /tmp/splunk.tgz
RUN rm -rf /tmp/splunkqa.tgz

EXPOSE 8000
EXPOSE 8089
