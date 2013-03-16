Description
===========

Installs cookbooks.haproxy and prepares the configuration location.

Requirements
============

## Platform

* Ubuntu (10.04+ due to config option change)
* Debian (6.0+)

Attributes
==========

* `node['cookbooks.haproxy']['incoming_address']` - sets the address to bind the
  cookbooks.haproxy process on, 0.0.0.0 (all addresses) by default
* `node['cookbooks.haproxy']['incoming_port']` - sets the port on which cookbooks.haproxy
  listens
* `node['cookbooks.haproxy']['member_port']` - the port that member systems will
  be listening on, default 80
* `node['cookbooks.haproxy']['app_server_role']` - used by the `app_lb` recipe
  to search for a specific role of member systems. Default
  `webserver`.
* `node['cookbooks.haproxy']['balance_algorithm']` - sets the load balancing
  algorithm; defaults to roundrobin.
* `node['cookbooks.haproxy']['enable_ssl']` - whether or not to create listeners
  for ssl, default false
* `node['cookbooks.haproxy']['ssl_incoming_address']` - sets the address to bind
  the cookbooks.haproxy on for SSL, 0.0.0.0 (all addresses) by default
* `node['cookbooks.haproxy']['ssl_member_port']` - the port that member systems
  will be listening on for ssl, default 8443
* `node['cookbooks.haproxy']['ssl_incoming_port']` - sets the port on which
  cookbooks.haproxy listens for ssl, default 443
* `node['cookbooks.haproxy']['httpchk']` - used by the `app_lb` recipe. If set,
  will configure httpchk in cookbooks.haproxy.conf
* `node['cookbooks.haproxy']['ssl_httpchk']` - used by the `app_lb` recipe. If
  set and `enable_ssl` is true, will configure httpchk in cookbooks.haproxy.conf
  for the `ssl_applicaiton` section
* `node['cookbooks.haproxy']['enable_admin']` - whether to enable the admin
  interface. default true. Listens on port 22002.
* `node['cookbooks.haproxy']['admin']['address_bind']` - sets the address to
  bind the administrative interface on, 127.0.0.1 by default
* `node['cookbooks.haproxy']['admin']['port']` - sets the port for the
  administrative interface, 22002 by default
* `node['cookbooks.haproxy']['pid_file']` - the PID file of the cookbooks.haproxy process,
  used in the tuning recipe.
* `node['cookbooks.haproxy']['defaults_options']` - an array of options to use
  for the config file's `defaults` stanza, default is
  ["httplog", "dontlognull", "redispatch"]
* `node['cookbooks.haproxy']['defaults_timeouts']['connect']` - connect timeout
  in defaults stanza
* `node['cookbooks.haproxy']['defaults_timeouts']['client']` - client timeout in
  defaults stanza
* `node['cookbooks.haproxy']['defaults_timeouts']['server']` - server timeout in
  defaults stanza
* `node['cookbooks.haproxy']['x_forwarded_for']` - if true, creates an
  X-Forwarded-For header containing the original client's IP address.
  This option disables KeepAlive.
* `node['cookbooks.haproxy']['member_max_connections']` - the maxconn value to
  be set for each app server
* `node['cookbooks.haproxy']['user']` - user that cookbooks.haproxy runs as
* `node['cookbooks.haproxy']['group']` - group that cookbooks.haproxy runs as
* `node['cookbooks.haproxy']['global_max_connections']` - in the `app_lb`
  config, set the global maxconn
* `node['cookbooks.haproxy']['member_max_connections']` - in both configs, set
  the maxconn per member
* `node['cookbooks.haproxy']['frontend_max_connections']` - in the `app_lb`
  config, set the the maxconn per frontend member
* `node['cookbooks.haproxy']['frontend_ssl_max_connections']` - in the `app_lb`
  config, set the maxconn per frontend member using SSL

Recipes
=======

## default

Sets up cookbooks.haproxy using statically defined configuration. To override
the configuration, modify the templates/default/cookbooks.haproxy.cfg.erb file
directly, or supply your own and override the cookbook and source by
reopening the `template[/etc/cookbooks.haproxy/cookbooks.haproxy.cfg]` resource.

## app\_lb

Sets up cookbooks.haproxy using dynamically defined configuration through
search. See __Usage__ below.

## tuning

Uses the community `cpu` cookbook's `cpu_affinity` LWRP to set
affinity for the cookbooks.haproxy process.

Usage
=====

Use either the default recipe or the `app_lb` recipe.

When using the default recipe, modify the cookbooks.haproxy.cfg.erb file with
listener(s) for your sites/servers.

The `app_lb` recipe is designed to be used with the application
cookbook, and provides search mechanism to find the appropriate
application servers. Set this in a role that includes the
cookbooks.haproxy::app_lb recipe. For example,

    name "load_balancer"
    description "cookbooks.haproxy load balancer"
    run_list("recipe[cookbooks.haproxy::app_lb]")
    override_attributes(
      "cookbooks.haproxy" => {
        "app_server_role" => "webserver"
      }
    )

The search uses the node's `chef_environment`. For example, create
`environments/production.rb`, then upload it to the server with knife

    % cat environments/production.rb
    name "production"
    description "Nodes in the production environment."
    % knife environment from file production.rb

License and Author
==================

- Author:: Joshua Timberman (<joshua@opscode.com>)
- Copyright:: 2009-2012, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.