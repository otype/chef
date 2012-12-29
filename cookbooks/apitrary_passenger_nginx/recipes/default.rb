#
# Cookbook Name:: apitrary_passenger_nginx
# Recipe:: default
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "build-essential"
include_recipe "carlo-chef-ruby1.9::default"

%w( libcurl4-openssl-dev libxslt-dev imagemagick).each do |pkg|
  package pkg do
    action :install
  end
end

%w( passenger ).each do |g|
  gem_package g do
    action :install
    gem_binary('/usr/local/bin/gem')
  end
end

execute "create nginx directories" do
  user "root"
  command "mkdir -p #{node['passenger_nginx']['prefix']}"
end

execute "create etc directories" do
  user "root"
  command "mkdir -p /etc/nginx/sites-enabled && mkdir -p /etc/nginx/sites-available"
end

execute "passenger-install-nginx-module" do
  user "root"
  command "passenger-install-nginx-module --auto --prefix=#{node['passenger_nginx']['prefix']} --auto-download"
  not_if { File.exists?("/opt/nginx/sbin/nginx") }
end

template "/opt/nginx/conf/nginx.conf" do
  source "nginx.conf.erb"
  mode 0644
  owner "root"
  group "root"
  variables(
      :worker_processes => node['passenger_nginx']['worker_processes'],
      :passenger_version => node['passenger_nginx']['passenger_version']
  )
end

template "/etc/init.d/nginx" do
  source "nginx.init.erb"
  owner "root"
  group "root"
  mode "0755"
  variables(
      :src_binary => node['passenger_nginx']['binary'],
      :pid => node['passenger_nginx']['pid']
  )
end
