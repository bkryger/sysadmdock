FROM fedora:41
LABEL maintainer="Bob Kryger <bkryger@gmail.com>"

RUN dnf -y update
RUN dnf -y install parallel ripgrep \
  curl wget vim git zip less yum-utils \
  jq yq yamllint

# Install Ansible
RUN dnf install -y ansible-core ansible-lint ansible-collection-community-* ansible-builder ansible-core-doc

# TODO
#  x yamllint
#  x yq https://github.com/mikefarah/yq
#  x powershell(?)
#  - bash debug
#  - fpm https://github.com/jordansissel/fpm
#     git clone https://github.com/jordansissel/fpm.git && (cd fpm && make install) 
#  - keypass-xc (w/ cli)
#  - kubectl
#  - snow & jira cmd line
#  - aws cli (other cloud tools)

# Install powershell7
RUN dnf install -y dnf-plugins-core \
    && dnf config-manager addrepo --from-repofile=https://packages.microsoft.com/config/rhel/7/prod.repo \
    && dnf install -y powershell

# Install Terraform and Packer
RUN dnf install -y dnf-plugins-core \
    && dnf config-manager addrepo --from-repofile=https://rpm.releases.hashicorp.com/fedora/hashicorp.repo \
    && dnf -y install packer

# Install OpenTofu
RUN curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh ;\
  bash ./install-opentofu.sh --install-method rpm ;\
  rm install-opentofu.sh

# Install inspec
RUN curl https://omnitruck.chef.io/install.sh | bash -s -- -P inspec

RUN yum -y clean all

# Add user and run as that user (UID 10000)
RUN useradd -U --uid 10000 --system --home /syseng --groups wheel syseng \
    && mkdir /syseng && chown syseng /syseng \
    && sed -i -e '/^%wheel/s/^/#/' -e '/^# %wheel/s/^# //' /etc/sudoers

USER syseng
WORKDIR /syseng

ENTRYPOINT ["/usr/bin/bash"]

