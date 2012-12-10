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
  template "/etc/nginx/sites-available/apitrary.com" do
    source "apitrary.com.erb"
    mode 0644
    owner "root"
    group "root"
    variables(
        :hostname => node['passenger_nginx']['hostnames']['www']['dev'].strip,
        :port => node['passenger_nginx']['port'],
        :rails_env => 'staging',
        :nodeenv => node.chef_environment
    )
  end
elsif node.chef_environment == "LIVE"
  template "/etc/nginx/sites-available/apitrary.com" do
    source "apitrary.com.erb"
    mode 0644
    owner "root"
    group "root"
    variables(
        :hostname_long => node['passenger_nginx']['hostnames']['www']['live_long'].strip,
        :hostname => node['passenger_nginx']['hostnames']['www']['live'].strip,
        :port => node['passenger_nginx']['port'],
        :rails_env => 'production',
        :nodeenv => node.chef_environment
    )
  end
end

execute "activate_apitrary.com" do
  user "root"
  command "ln -nsf /etc/nginx/sites-available/apitrary.com /etc/nginx/sites-enabled/apitrary.com"
end
