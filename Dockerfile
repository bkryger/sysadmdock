FROM fedora:41
LABEL maintainer="Bob Kryger <bkryger@gmail.com>"

# TODO - Add user and run as that user (UID 10000)
# RUN addgroup --gid 10001 --system sysadm \
#  && adduser  --uid 10000 --system --ingroup sysadm --home /home/nonroot sysadm

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

# Install powershell7
#RUN dnf install https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell-7.4.6-1.rh.x86_64.rpm
RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo \
  && dnf install -y powershell

#run curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" ;\
#  ls -l ;\
#  unzip awscliv2.zip ;\
#  ./aws/install

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

RUN groupadd -r syseng && useradd -r -g syseng syseng \
  && mkdir /syseng && chown syseng /syseng

USER syseng
WORKDIR /syseng

ENTRYPOINT ["/usr/bin/bash"]

