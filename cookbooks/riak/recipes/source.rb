#
# Author:: Seth Thomas (<sthomas@basho.com>)
# Cookbook Name:: cookbooks.riak
# Recipe:: source
#
# Copyright (c) 2013 Basho Technologies, Inc.
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

source_version = "#{node['cookbooks.riak']['source']['version']['major']}.#{node['cookbooks.riak']['source']['version']['minor']}"
source_uri = "#{node['cookbooks.riak']['source']['url']}/#{source_version}/#{source_version}.#{node['cookbooks.riak']['source']['version']['incremental']}/"
source_file = "cookbooks.riak-#{source_version}.#{node['cookbooks.riak']['source']['version']['incremental']}"
source_filename = "#{source_file}.tar.gz"

include_recipe "git"
include_recipe "build-essential"
include_recipe "erlang::source"

group "cookbooks.riak"

user "cookbooks.riak" do
  gid "cookbooks.riak"
  shell "/bin/bash"
  home "/var/lib/cookbooks.riak"
  system true
end

remote_file "#{Chef::Config[:file_cache_path]}/#{source_filename}" do
  source source_uri + source_filename
  owner "root"
  mode 0644
  not_if { File.exists?("#{Chef::Config[:file_cache_path]}/#{source_filename}") && Digest::SHA256.file("#{Chef::Config[:file_cache_path]}/#{source_filename}").hexdigest == node['cookbooks.riak']['source']['checksum'] }
end

execute "cookbooks.riak-src-unpack" do
  cwd Chef::Config[:file_cache_path]
  command "tar xvfz #{source_filename}"
end

execute "cookbooks.riak-src-build" do
  cwd "#{Chef::Config[:file_cache_path]}/#{source_file}"
  command "make clean all rel"
end

execute "cookbooks.riak-src-install" do
  command "mv #{Chef::Config[:file_cache_path]}/#{source_file}/rel/cookbooks.riak #{node['cookbooks.riak']['source']['prefix']}"
  not_if { File.directory?("#{node['cookbooks.riak']['source']['prefix']}/cookbooks.riak") }
end

file "#{node['cookbooks.riak']['source']['config_dir']}/app.config" do
  content Eth::Config.new(node['cookbooks.riak']['config'].to_hash).pp
  owner "root"
  mode 0644
end

file "#{node['cookbooks.riak']['source']['config_dir']}/vm.args" do
  content Eth::Args.new(node['cookbooks.riak']['args'].to_hash).pp
  owner "root"
  mode 0644
end

node['cookbooks.riak']['patches'].each do |patch|
  cookbook_file "#{node['cookbooks.riak']['source']['prefix']}/cookbooks.riak/lib/basho-patches/#{patch}" do
    source patch
    owner "root"
    mode 0644
    checksum
    notifies :restart, "service[cookbooks.riak]"
  end
end