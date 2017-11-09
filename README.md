Openstack-Ansible Telegraf
==========================

This role is used to create and manage telegraf in an openstack-ansible-based deployment.

Requirements
------------

An openstack-ansible deployment is required.

Role Variables
--------------

By default, the role does not configure any output. The available choices are Graphite / InfluxDB over AMQP or InfluxDB.

Dependencies
------------

None.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: all
      gather_facts: "{{ gather_facts | default(True) }}"
      user: root
      roles:
         - { role: ansible-telegraf }
      vars:
         telegraf_output: amqp
         telegraf_output_amqp_user: metrics
         telegraf_output_amqp_password: secret # should be in user_secrets.yml
         telegraf_output_amqp_server: my-mq.local
         telegraf_output_amqp_vhost: /
         telegraf_output_amqp_url: "amqp://{{ telegraf_output_amqp_user }}:{{ telegraf_output_amqp_password }}@{{ telegraf_output_amqp_server }}:5672/{{ telegraf_output_amqp_vhost }}"

License
-------

GPL-3+

Author Information
------------------

Mathieu GRZYBEK
