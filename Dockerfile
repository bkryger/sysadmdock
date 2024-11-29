FROM fedora:41

#RUN dnf -y install config-manager
#RUN dnf config-manager --set-enabled powertools
RUN dnf -y update
#RUN dnf -y install epel-release
RUN dnf -y install parallel ripgrep

RUN dnf install -y \
  curl \
  wget \
  vim \
  git \
  zip \
  less \
  yum-utils \
  jq yq yamllint

RUN dnf install -y ansible-core ansible-lint ansible-collection-community-*

# TODO
#  - yamllint
#  - yq https://github.com/mikefarah/yq
#  - powershell(?)

#run curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" ;\
#  ls -l ;\
#  unzip awscliv2.zip ;\
#  ./aws/install

RUN yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo ;\
  yum -y install terraform packer ;\
  curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh ;\
  bash ./install-opentofu.sh --install-method rpm ;\
  rm install-opentofu.sh ;\
  curl https://omnitruck.chef.io/install.sh | bash -s -- -P inspec

ENTRYPOINT ["/usr/bin/bash"]

