FROM quay.io/acme_corp/rhel_90_ee:latest

USER 0

# Install Python 3.11 and pip
RUN dnf install -y python3.11 python3.11-pip && \
    dnf clean all

# Install Ansible Core 2.16.14 using Python 3.11
RUN python3.11 -m pip install --no-cache-dir ansible-core==2.16.14

# Install required Ansible collections
RUN ansible-galaxy collection install \
    ansible.controller \
    ansible.platform \
    servicenow.itsm:2.13.2 \
    -p /usr/share/ansible/collections

# Make sure the new Ansible executable is used
ENV PATH="/usr/local/bin:${PATH}"

# Verify installation
RUN ansible --version && \
    ansible-galaxy collection list

USER 1000