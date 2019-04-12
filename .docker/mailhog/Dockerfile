FROM alpine:3.4
MAINTAINER Victor Todoran "victor.todoran@evozon.com"

# Install ca-certificates, required for the "release message" feature:
RUN apk --no-cache add \
    ca-certificates

# Add bash
RUN apk update && apk add bash && apk add sudo

# Install MailHog:
RUN apk --no-cache add --virtual build-dependencies \
    go \
    git \
  && mkdir -p /root/gocode \
  && export GOPATH=/root/gocode \
  && go get github.com/mailhog/MailHog \
  && mv /root/gocode/bin/MailHog /usr/local/bin \
  && rm -rf /root/gocode \
  && apk del --purge build-dependencies

# Add mailhog user/group with uid/gid 1000.
# This is a workaround for boot2docker issue #581, see
# https://github.com/boot2docker/boot2docker/issues/581
RUN adduser -D -u 1001 mailhog

USER root

WORKDIR /home/mailhog

RUN mkdir /home/mailhog/emails && chown -R mailhog:mailhog /home/mailhog/emails \
    && chmod -R 775 /home/mailhog/emails

ENTRYPOINT ["MailHog", "-storage=maildir","-maildir-path=/home/mailhog/emails"]

# Expose the SMTP and HTTP ports:
EXPOSE 1025 8025