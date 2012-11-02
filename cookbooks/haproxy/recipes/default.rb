#
# Cookbook Name:: haproxy
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
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

package "haproxy" do
  action :install
end

template "/etc/default/haproxy" do
  source "haproxy-default.erb"
  owner "root"
  group "root"
  mode 0644
end

service "haproxy" do
  supports :restart => true, :status => true, :reload => true
  action [:enable, :start]
end

# We need this temporarily before we switch our old LIVE apitrary.com to the new server.
web_nodes = search(:node, "chef_environment:#{node.chef_environment} AND role:railsweb")
web_acl = 'www'
if node.chef_environment == 'LIVE'
  web_acl = 'www2'
end

template "/etc/haproxy/haproxy.cfg" do
  source "haproxy.cfg.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[haproxy]"
  variables(
      :webacl => web_acl,
      :webnodes => web_nodes
  )

  # THIS HERE IS IMPORTANT!! The deployr writes to this
  # config ... we don't want chef to overwrite the working config!!!!
  #not_if {File.exists?("/etc/haproxy/haproxy.cfg")}
end
