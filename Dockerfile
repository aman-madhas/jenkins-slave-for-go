FROM alpine:latest

RUN apk add --no-cache openssh man man-pages

#RUN mkdir -p /var/run/sshd

RUN adduser -D jenkins

RUN ssh-keygen -A

USER jenkins

RUN ssh-keygen -t rsa -N "" -f my.key

# Standard SSH port
EXPOSE 22

# Default command
CMD ["/usr/sbin/sshd", "-D"]