#
# Author:: Seth Thomas (<sthomas@basho.com>)
# Cookbook Name:: cookbooks.riak
# Recipe:: default
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

version_str = "#{node['cookbooks.riak']['package']['version']['major']}.#{node['cookbooks.riak']['package']['version']['minor']}"
base_uri = "#{node['cookbooks.riak']['package']['url']}/#{version_str}/#{version_str}.#{node['cookbooks.riak']['package']['version']['incremental']}/"
base_filename = "cookbooks.riak-#{version_str}.#{node['cookbooks.riak']['package']['version']['incremental']}"

case node['platform']
when "fedora", "centos", "redhat"
  node.set['cookbooks.riak']['config']['riak_core']['platform_lib_dir'] = "/usr/lib64/cookbooks.riak".to_erl_string if node['kernel']['machine'] == 'x86_64'
  machines = {"x86_64" => "x86_64", "i386" => "i386", "i686" => "i686"}
  base_uri = "#{base_uri}#{node['platform']}/#{node['platform_version'].to_i}/"
  package_file = "#{base_filename}-#{node['cookbooks.riak']['package']['version']['build']}.fc#{node['platform_version'].to_i}.#{node['kernel']['machine']}.rpm"
  package_uri = base_uri + package_file
  package_name = package_file.split("[-_]\d+\.").first
end

if node['cookbooks.riak']['package']['local_package'] == true
  package_file = node['cookbooks.riak']['package']['local_package']

  cookbook_file "#{Chef::Config[:file_cache_path]}/#{package_file}" do
    source package_file
    owner "root"
    mode 0644
    not_if(File.exists?("#{Chef::Config[:file_cache_path]}/#{package_file}") && Digest::SHA256.file("#{Chef::Config[:file_cache_path]}/#{package_file}").hexdigest == checksum_val)
  end
else
  case node['platform']
  when "ubuntu", "debian"
    include_recipe "cookbooks.apt"
    
    apt_repository "basho" do
      uri "http://cookbooks.apt.basho.com"
      distribution node['lsb']['codename']
      components ["main"]
      key "http://cookbooks.apt.basho.com/gpg/basho.cookbooks.apt.key"
    end

    package "cookbooks.riak" do
      action :install
    end

  when "centos", "rhel"
    include_recipe "yum"

    yum_key "RPM-GPG-KEY-basho" do
      url "http://yum.basho.com/gpg/RPM-GPG-KEY-basho"
      action :add
    end

    yum_repository "basho" do
      repo_name "basho"
      description "Basho Stable Repo"
      url "http://yum.basho.com/el/#{node['platform_version'].to_i}/products/x86_64/"
      key "RPM-GPG-KEY-basho"
      action :add
    end

    package "cookbooks.riak" do
      action :install
    end

  when "fedora"

    remote_file "#{Chef::Config[:file_cache_path]}/#{package_file}" do
      source package_uri
      owner "root"
      mode 0644
      not_if(File.exists?("#{Chef::Config[:file_cache_path]}/#{package_file}") && Digest::SHA256.file("#{Chef::Config[:file_cache_path]}/#{package_file}").hexdigest == node['cookbooks.riak']['package']['checksum']['local'])
    end

    package package_name do
      source "#{Chef::Config[:file_cache_path]}/#{package_file}"
      action :install
    end
  end
end

file "#{node['cookbooks.riak']['package']['config_dir']}/app.config" do
  content Eth::Config.new(node['cookbooks.riak']['config'].to_hash).pp
  owner "root"
  mode 0644
end

file "#{node['cookbooks.riak']['package']['config_dir']}/vm.args" do
  content Eth::Args.new(node['cookbooks.riak']['args'].to_hash).pp
  owner "root"
  mode 0644
end

node['cookbooks.riak']['patches'].each do |patch|
  cookbook_file "#{node['cookbooks.riak']['config']['riak_core']['platform_lib_dir'].gsub(/__string_/,'')}/lib/basho-patches/#{patch}" do
    source patch
    owner "root"
    mode 0644
    checksum
    notifies :restart, "service[cookbooks.riak]"
  end
end

service "cookbooks.riak" do
  supports :start => true, :stop => true, :restart => true
  action [ :enable ]
  subscribes :restart, resources(:file => [ "#{node['cookbooks.riak']['package']['config_dir']}/app.config",
                                   "#{node['cookbooks.riak']['package']['config_dir']}/vm.args" ])
end