#
# Cookbook Name:: apitrary_passenger_nginx
# Recipe:: launchpad
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apitrary_passenger_nginx::default"

rails_env = 'staging'
node_env = 'dev'
servers = 1
if node.chef_environment == "LIVE"
  rails_env = 'production'
  node_env = 'live'
  servers = 4
end

%w(launchpad.apitrary.com launchpad.apitrary.com.thin.sock).each do |host|
  template "/etc/nginx/sites-available/#{host}" do
    source "#{host}.erb"
    mode 0644
    owner "root"
    group "root"
    variables(
        :hostname => node['passenger_nginx']['hostnames']['launchpad'][node_env].strip,
        :port => node['passenger_nginx']['port'],
        :rails_env => rails_env
    )
  end
end

directory "/etc/thin" do
  mode 0755
  owner "root"
  group "root"
end

template "/etc/thin/launchpad.yml" do
  source "thin.name.yml.erb"
  mode 0644
  owner "root"
  group "root"
  variables(
      :rails_env => rails_env,
      :thin_servers => servers,
      :name => "launchpad"
  )
end

execute "activate_launchpad.apitrary.com" do
  user "root"
  command "ln -nsf /etc/nginx/sites-available/launchpad.apitrary.com.thin.sock /etc/nginx/sites-enabled/launchpad.apitrary.com.thin.sock"
end
