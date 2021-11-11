FROM zireael13/dind-awscli-make-git as maker



FROM gcr.io/kaniko-project/executor as kaniko


FROM alpine

COPY --from=maker /usr/bin/make /usr/bin/make
COPY --from=kaniko /kaniko /kaniko
COPY --from=kaniko /etc/nsswitch.conf /etc/nsswitch.conf

ENV HOME /root
ENV USER root
ENV PATH $PATH:/usr/local/bin:/kaniko
ENV SSL_CERT_DIR=/kaniko/ssl/certs
ENV DOCKER_CONFIG /kaniko/.docker/
ENV DOCKER_CREDENTIAL_GCR_CONFIG /kaniko/.config/gcloud/docker_credential_gcr_config.json

