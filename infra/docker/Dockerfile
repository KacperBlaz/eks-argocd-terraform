ARG ALPINE_VERSION=3.18.4

FROM alpine:${ALPINE_VERSION} as builder

ARG ENVIRONMENT="dev"
ARG HELM_VERSION=v3.14.0
ARG KUBECTL_VERSION=1.28
ARG TERRAFORM_VERSION=1.6.6


RUN \
   apk update && \
   apk add --no-cache aws-cli bash build-base cmake curl curl-dev gcc git groff libffi-dev libc-dev make musl-dev openssl-dev pcre2 tar unzip wget && \
   apk upgrade && \
   curl -sLO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
   chmod +x kubectl && \
   mv ./kubectl /usr/local/bin/kubectl && \
   wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
   unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
   rm -rf ./terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
   chmod +x terraform && \
   mv ./terraform /usr/local/bin && \
   chmod +x /usr/bin/git && \
   mv /usr/bin/git /usr/local/bin && \
   wget https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz && \
   tar -xf helm-${HELM_VERSION}-linux-amd64.tar.gz && \
   chmod +x ./linux-amd64/helm && \
   mv ./linux-amd64/helm /usr/local/bin



COPY ./ ./

FROM frolvlad/alpine-glibc as runner
COPY --from=builder ./env/${ENVIRONMENT} ./env/${ENVIRONMENT}
COPY --from=builder ./modules ./modules
COPY --from=builder /usr /usr
WORKDIR /infra/env/${ENVIRONMENT}
