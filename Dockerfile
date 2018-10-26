FROM ubuntu:16.04
MAINTAINER prabhakar@foxutech.com

RUN apt update
RUN apt -y upgrade
RUN apt install -y git openssh-server openjdk-8-jdk maven

RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

RUN adduser --quiet jenkins
RUN echo "jenkins:jenkins" | chpasswd

RUN mkdir /home/jenkins/.m2
ADD settings.xml /home/jenkins/.m2/
RUN chown -R jenkins:jenkins /home/jenkins/.m2/ 

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
