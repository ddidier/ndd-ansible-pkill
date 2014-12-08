#
# ddidier/ansible-pkill
#   docker build -t ddidier/ansible-pkill .
#
# Thanks to:
#   https://github.com/AnsibleShipyard/ansible-base-ubuntu
#

FROM ubuntu:14.04
MAINTAINER David DIDIER

RUN apt-get clean
RUN apt-get -y update
RUN apt-get install -y python-dev python-yaml python-jinja2 git unzip python-pip
RUN pip install paramiko PyYAML jinja2 httplib2 boto
RUN git clone --recursive http://github.com/ansible/ansible.git /tmp/ansible

WORKDIR /tmp/ansible

ENV ANSIBLE_LIBRARY /tmp/ansible/library
ENV PATH            /tmp/ansible/bin:/sbin:/usr/sbin:/usr/bin:/bin:$PATH
ENV PYTHONPATH      /tmp/ansible/lib:$PYTHON_PATH

# /tmp/ansible ...
# /tmp/build
# |-- playbook.yml
# `-- roles
#     `-- pkill
#         |-- meta
#         |   `-- main.yml
#         |-- tasks
#         |   `-- main.yml
#         `-- vars
#             `-- main.yml

ENV BUILD_DIR /tmp/build
ENV ROLES_DIR $BUILD_DIR/roles
ENV ROLE_DIR  $ROLES_DIR/pkill

RUN mkdir -p $ROLE_DIR

# Role files
ADD defaults $ROLE_DIR/defaults
ADD meta     $ROLE_DIR/meta
ADD tasks    $ROLE_DIR/tasks
ADD vars     $ROLE_DIR/vars

# Test files
ADD tests/inventory       /etc/ansible/hosts
ADD tests/playbook.yml    $BUILD_DIR/playbook.yml

# Test
RUN ansible-playbook $BUILD_DIR/playbook.yml -c local
