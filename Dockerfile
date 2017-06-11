FROM alpine:latest

RUN apk add --no-cache openssh man man-pages

RUN mkdir -p /var/run/sshd

RUN ssh-keygen -A

# Set SSH Configuration to allow remote logins without /proc write access
RUN sed -ri 's/^session\s+required\s+pam_loginuid.so$/session optional pam_loginuid.so/' /etc/ssh/sshd_config

# Create Jenkins User
#RUN useradd jenkins -m -s /bin/bash

#RUN adduser -m -s /bin/bash jenkins
RUN adduser -D jenkins

RUN echo "jenkins:jenkins" | chpasswd

# Add public key for Jenkins login
RUN mkdir /home/jenkins/.ssh
COPY /files/authorized_keys /home/jenkins/.ssh/authorized_keys
RUN chown -R jenkins /home/jenkins
RUN chgrp -R jenkins /home/jenkins
RUN chmod 600 /home/jenkins/.ssh/authorized_keys
RUN chmod 700 /home/jenkins/.ssh

# Add the jenkins user to sudoers
RUN echo "jenkins  ALL=(ALL)  ALL" >> etc/sudoers

# Set Name Servers
COPY /files/resolv.conf /etc/resolv.conf

# Standard SSH port
EXPOSE 22

# Default command
CMD ["/usr/sbin/sshd", "-D"]