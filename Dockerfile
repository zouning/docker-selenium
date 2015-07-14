# sshd
#
# VERSION               0.0.2

#FROM selenium/standalone-firefox:2.46.0
FROM ubuntu:latest
MAINTAINER Ning Zou <nzou@splunk.com>

USER root

#====================================
# Setup git
#====================================
RUN apt-get update && apt-get install -y git openssh-server

#====================================
# Setup SSH Server
#====================================
RUN apt-get update && apt-get install -y x11vnc xvfb
RUN mkdir /var/run/sshd
RUN echo 'root:changeme' | chpasswd
RUN sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

RUN mkdir ~/.vnc
# Setup a password
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd
EXPOSE 5900


#====================================
# Scripts to run Selenium Standalone
#====================================
COPY entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh

#EXPOSE 4444

#====================================
# Scripts to setup splunk and test
#====================================
#COPY splunk.tgz /tmp/splunk.tgz
#WORKDIR /tmp
#RUN tar zxvf splunk.tgz
#COPY splunkqa.tgz /tmp/splunkqa.tgz
#RUN tar zxvf splunkqa.tgz
#VOLUME /splunkdb
#RUN echo "SPLUNK_DB=/splunkdb" >> splunk/etc/splunk-launch.conf.default
# Clean up useless tgz package
#RUN rm -rf /tmp/splunk.tgz
#RUN rm -rf /tmp/splunkqa.tgz

#EXPOSE 8000
#EXPOSE 8089
ENTRYPOINT ["/opt/bin/entry_point.sh"]
