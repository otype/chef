#
# Cookbook Name:: apitrary_passenger_nginx
# Recipe:: source
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "build-essential"

nginx_installed_check = "nginx -v | grep \"v#{node[:passenger_nginx][:version]}\""

execute "get & unpack nginx }" do
  user "root"
  command "cd /usr/src && wget -N http://nginx.org/download/nginx-#{node[:passenger_nginx][:version]}.tar.gz && tar xzf nginx-#{ node[:passenger_nginx][:version] }.tar.gz && cd nginx-#{ node[:passenger_nginx][:version] }"
  not_if nginx_installed_check
end

execute "configure & make #{ node[:passenger_nginx][:version] } & install" do
  user "root"
  command "cd /usr/src/nginx-#{node[:passenger_nginx][:version]} && ./configure && make && make install"
  not_if nginx_installed_check
end