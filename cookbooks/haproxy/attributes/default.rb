#
# Cookbook Name:: cookbooks.haproxy
# Default:: default
#
# Copyright 2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['cookbooks.haproxy']['incoming_address'] = "0.0.0.0"
default['cookbooks.haproxy']['incoming_port'] = 80
default['cookbooks.haproxy']['member_port'] = 8080
default['cookbooks.haproxy']['app_server_role'] = "webserver"
default['cookbooks.haproxy']['balance_algorithm'] = "roundrobin"
default['cookbooks.haproxy']['enable_ssl'] = false
default['cookbooks.haproxy']['ssl_incoming_address'] = "0.0.0.0"
default['cookbooks.haproxy']['ssl_incoming_port'] = 443
default['cookbooks.haproxy']['ssl_member_port'] = 8443
default['cookbooks.haproxy']['httpchk'] = nil
default['cookbooks.haproxy']['ssl_httpchk'] = nil
default['cookbooks.haproxy']['enable_admin'] = true
default['cookbooks.haproxy']['admin']['address_bind'] = "127.0.0.1"
default['cookbooks.haproxy']['admin']['port'] = 22002
default['cookbooks.haproxy']['pid_file'] = "/var/run/cookbooks.haproxy.pid"

default['cookbooks.haproxy']['defaults_options'] = ["httplog", "dontlognull", "redispatch"]
default['cookbooks.haproxy']['x_forwarded_for'] = false
default['cookbooks.haproxy']['defaults_timeouts']['connect'] = "5s"
default['cookbooks.haproxy']['defaults_timeouts']['client'] = "50s"
default['cookbooks.haproxy']['defaults_timeouts']['server'] = "50s"

default['cookbooks.haproxy']['user'] = "cookbooks.haproxy"
default['cookbooks.haproxy']['group'] = "cookbooks.haproxy"

default['cookbooks.haproxy']['global_max_connections'] = 4096
default['cookbooks.haproxy']['member_max_connections'] = 100
default['cookbooks.haproxy']['frontend_max_connections'] = 2000
default['cookbooks.haproxy']['frontend_ssl_max_connections'] = 2000
