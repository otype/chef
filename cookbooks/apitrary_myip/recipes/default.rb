#
# Cookbook Name:: apitrary_myip
# Recipe:: default
#
# Copyright 2013, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "user::default"
include_recipe "supervisor::default"

user_account 'myip' do
  comment   'My IP'
  home      '/home/myip'
  shell     '/usr/sbin/nologin'
  not_if {File.exists?("/home/myip")}
end

template "/etc/supervisor/conf.d/myip.conf" do
  source "supervisor_myip.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :run, 'execute[supervisor_myip_add]', :immediately
end

execute "pip-install-myip" do
  command "pip install git+ssh://git@github.com/apitrary/myip.git"
  user "root"
  not_if {File.exists?("/usr/local/bin/myip_runner.py")}
end

execute "supervisor_myip_add" do
  user "root"
  command "supervisorctl stop myip; supervisorctl remove myip ; supervisorctl reread && supervisorctl add myip"
  action :nothing
end

execute "supervisor_myip_restart" do
  user "root"
  command "supervisorctl reread && supervisorctl restart myip"
  action :nothing
end
