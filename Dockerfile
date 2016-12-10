FROM ubuntu:16.04
MAINTAINER Yuvaraj H K <h.k.yuvaraj@gmail.com>

# Make sure the package repository is up to date.
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y git
# Install a basic SSH server
RUN apt-get install -y openssh-server
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Install JDK 8
RUN apt-get install -y openjdk-8-jdk
# Your JAVA_HOME will be /usr/lib/jvm/java-1.8.0-openjdk-amd64/ .You many need this to set in manage jenkins > Global tools config

# Add user jenkins to the image
RUN adduser --quiet jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

RUN mkdir /home/jenkins/.m2

ADD resources/settings.xml /home/jenkins/.m2/

RUN chown -R jenkins:jenkins /home/jenkins/.m2/ 

RUN apt-get install -y maven
# Your MAVEN_HOME will be /usr/share/maven .You many need this to set in manage jenkins > Global tools config

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
