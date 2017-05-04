FROM alpine:latest

RUN apk add --no-cache openssh man man-pages

RUN mkdir -p /var/run/sshd

RUN ssh-keygen -A

RUN adduser -D jenkins

RUN echo "jenkins:jenkins" | chpasswd

# Standard SSH port
EXPOSE 22

# Default command
CMD ["/usr/sbin/sshd", "-D"]