#
# Cookbook Name:: apitrary_nodejs
# Recipe:: default
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
nodejs_installed_check = "node -v | grep \"v#{node[:nodejs][:version]}\""

%w(libpq-dev git-core curl build-essential openssl libssl-dev).each do |pkg|
  package pkg do
    action :install
  end
end

execute "get & unpack node.js }" do
  user "root"
  command "cd /usr/src && wget -N http://nodejs.org/dist/v#{node[:nodejs][:version]}/node-v#{node[:nodejs][:version]}.tar.gz && tar xzf node-v#{ node[:nodejs][:version] }.tar.gz && cd node-v#{ node[:nodejs][:version] }"
  not_if nodejs_installed_check
end

execute "configure & make #{ node[:nodejs][:version] }" do
  user "root"
  command "cd /usr/src/node-v#{ node[:nodejs][:version] } && ./configure && make && make install"
  not_if nodejs_installed_check
end

