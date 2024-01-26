ARG BASE_IMAGE

FROM $BASE_IMAGE

ARG TERRAFORM_BINARY_VERSION
ARG ONEPASSWORD_BINARY_VERSION

RUN apk add --no-cache \
    curl \
    gcompat \
    git \
    idn2-utils \
    jq \
    openssh

WORKDIR /tmp

RUN ( curl -sLo terraform.zip "https://releases.hashicorp.com/terraform/${TERRAFORM_BINARY_VERSION}/terraform_${TERRAFORM_BINARY_VERSION}_linux_amd64.zip" && \
    unzip terraform.zip && \
    rm terraform.zip && \
    mv ./terraform /usr/local/bin/terraform \
    ) && terraform --version

RUN ( curl -sLo op.zip "https://cache.agilebits.com/dist/1P/op2/pkg/v${ONEPASSWORD_BINARY_VERSION}/op_linux_amd64_v${ONEPASSWORD_BINARY_VERSION}.zip" && \
    unzip op.zip && \
    rm op.zip && \
    mv ./op /usr/local/bin/op \
    ) && op --version

WORKDIR /

ENTRYPOINT []