#
# Cookbook Name:: apitrary_passenger_nginx
# Recipe:: launchpad
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apitrary_passenger_nginx::default"

if node.chef_environment == "DEV"
  template "/etc/nginx/sites-available/launchpad.apitrary.com" do
    source "launchpad.apitrary.com.erb"
    mode 0644
    owner "root"
    group "root"
    variables(
        :hostname => node['passenger_nginx']['hostnames']['launchpad']['dev'].strip,
        :port => node['passenger_nginx']['port']
    )
  end
  elsif node.chef_environment == "LIVE"
  template "/etc/nginx/sites-available/launchpad.apitrary.com" do
    source "launchpad.apitrary.com.erb"
    mode 0644
    owner "root"
    group "root"
    variables(
        :hostname => node['passenger_nginx']['hostnames']['launchpad']['live'].strip,
        :port => node['passenger_nginx']['port']
    )
  end
end

execute "activate_launchpad.apitrary.com" do
  user "root"
  command "ln -nsf /etc/nginx/sites-available/launchpad.apitrary.com /etc/nginx/sites-enabled/launchpad.apitrary.com"
end
