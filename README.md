


Usage
-----

docker run --rm -it -v $(pwd):$(pwd) -w $(pwd) --entrypoint bash syseng:test2

For Ansible

```
# docker run --rm \
# 	-it \
# 	-v ${PWD}/hosts:/etc/ansible/hosts \
# 	-v ${PWD}/ansible.cfg:/etc/ansible/ansible.cfg \
# 	-v ${HOME}/.ssh:/root/.ssh:ro \
# 	ansible all -m ping
```

For inspec


## What's installed
- Ansible
- Inspec
- Terraform
- Packer
- OpenTofu
- Powershell

