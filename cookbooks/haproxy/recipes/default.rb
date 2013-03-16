#
# Cookbook Name:: cookbooks.haproxy
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

package "cookbooks.haproxy" do
  action :install
end

cookbook_file "/etc/default/cookbooks.haproxy" do
  source "cookbooks.haproxy-default"
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[cookbooks.haproxy]"
end

template "/etc/cookbooks.haproxy/cookbooks.haproxy.cfg" do
  source "cookbooks.haproxy.cfg.erb"
  owner "root"
  group "root"
  mode 00644
  notifies :reload, "service[cookbooks.haproxy]"
end

service "cookbooks.haproxy" do
  supports :restart => true, :status => true, :reload => true
  action [:enable, :start]
end
