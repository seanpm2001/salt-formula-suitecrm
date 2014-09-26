{%- from "suitecrm/map.jinja" import server with context %}
{%- from "apache/map.jinja" import server_apache with context %}

{%- if server.enabled %}

suitecrm_packages:
  pkg.installed:
  - names:
    - unzip
{%- if grains.osfullname in ['Ubuntu'] %}
    - php5-mysql
    - php5-imap
    - php5-curl
    - php5-gd
    - cron
{%- elif grains.osfullname in ['CentOS'] %}
    - cronie
{%- endif %}

suitecrm_dir:
  file.directory:
  - name: {{ server.dir }}/sites
  - makedirs: true

suitecrm_service:
  service.running:
  - name: {{ server_apache.service }}
  - reload: true
  - enable: true
  - require:
    - pkg: apache_packages
  - watch:
    - pkgs: /suitecrm_package

{%- endif %}
