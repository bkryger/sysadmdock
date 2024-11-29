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
RUN dnf install -y ansible-core ansible-lint ansible-collection-community-*

# TODO
#  - yamllint
#  - yq https://github.com/mikefarah/yq
#  - powershell(?)
#  - bash debug
#  - fpm https://github.com/jordansissel/fpm
#     git clone https://github.com/jordansissel/fpm.git && (cd fpm && make install) 
#  - keypass-xc (w/ cli)
#  - kubectl
#  - snow & jira cmd line


#run curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" ;\
#  ls -l ;\
#  unzip awscliv2.zip ;\
#  ./aws/install

# Install Terraform, packer and OpenTofu
RUN dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo ;\
  dnf -y install terraform packer ;\
  curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh ;\
  bash ./install-opentofu.sh --install-method rpm ;\
  rm install-opentofu.sh

# Install inspec
RUN curl https://omnitruck.chef.io/install.sh | bash -s -- -P inspec

RUN yum -y clean all

# USER sysadm

ENTRYPOINT ["/usr/bin/bash"]

