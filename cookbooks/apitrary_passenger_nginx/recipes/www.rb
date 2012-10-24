#
# Cookbook Name:: apitrary_passenger_nginx
# Recipe:: www
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apitrary_passenger_nginx::default"

if node.chef_environment == "DEV"
  template "/etc/nginx/sites-available/apitrary.com.thin" do
    source "apitrary.com.thin.erb"
    mode 0644
    owner "root"
    group "root"
    variables(
        :hostname => node['passenger_nginx']['hostnames']['www']['dev'].strip,
        :port => node['passenger_nginx']['port']
    )
  end
  elsif node.chef_environment == "LIVE"
  template "/etc/nginx/sites-available/apitrary.com.thin" do
    source "apitrary.com.thin.erb"
    mode 0644
    owner "root"
    group "root"
    variables(
        :hostname => node['passenger_nginx']['hostnames']['www']['live'].strip,
        :port => node['passenger_nginx']['port']
    )
  end
end

execute "activate_apitrary.com.thin" do
  user "root"
  command "ln -nsf /etc/nginx/sites-available/apitrary.com.thin /etc/nginx/sites-enabled/apitrary.com.thin"
end
