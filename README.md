# System Admin and Engineering Tools Container

This would be like a jump host to perform mass config runs and such.
Use as a command line with all your favorite tools installed for dev/admin/eng.



Usage
-----

1. Get a command line
```
docker run --rm -it -v $(pwd):$(pwd) -w $(pwd) --entrypoint bash syseng:latest
```

3. For Ansible

```
# docker run --rm \
# 	-it \
# 	-v ${PWD}/hosts:/etc/ansible/hosts \
# 	-v ${PWD}/ansible.cfg:/etc/ansible/ansible.cfg \
# 	-v ${HOME}/.ssh:/root/.ssh:ro \
# 	ansible all -m ping
```

3. For inspec \
TBD

## What's installed
- Ansible
- Inspec
- Terraform
- Packer
- OpenTofu
- Powershell

## PowerShell is installed
* See https://learn.microsoft.com/en-us/powershell/scripting/whats-new/unix-support?view=powershell-7.4&viewFallbackFrom=powershell-7.2

I just thought it might be useful to have.  That is a linux version of powershell. ￼
Start the container and run pwsh to get a powershell command line.
I'm thinking that maybe that gets its own container so that the libraries can be installed, or maybe just in this container
I may remove it entirely since you cannot manage a windows box from a linux version of Powershell.  No wmi commands...  Although you can use ssh with it.

## TODO
- command history
- fzf, exa/eza, etc
- tldr, tealdeer, man pages, other docs

## Build
Build the container
```
docker build --tag syseng:latest .
```

