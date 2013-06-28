#
# Cookbook Name:: apitrary_pytools
# Recipe:: deployr
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "user::default"
include_recipe "supervisor::default"
include_recipe "apitrary_pytools::default"
include_recipe "apitrary_pytools::pytools"

user_account 'deployr' do
  comment   'Deployr User'
  home      '/home/deployr'
  shell     '/usr/sbin/nologin'
  not_if {File.exists?("/home/deployr")}
end

directory "/etc/deployr" do
  owner "root"
  group "root"
  mode 0700
end

template "/etc/deployr/deployr.conf" do
  source "deployr.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :run, 'execute[supervisor_deployr_add]', :immediately
end

template "/etc/supervisor/conf.d/deployr.conf" do
  source "supervisor_deployr.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :run, 'execute[supervisor_deployr_add]', :immediately
end

execute "supervisor_deployr_add" do
  user "root"
  command "supervisorctl stop deployr ; supervisorctl remove deployr ; supervisorctl reread && supervisorctl add deployr"
  action :nothing
end

execute "supervisor_deployr_restart" do
  user "root"
  command "supervisorctl reread && supervisorctl restart deployr"
  action :nothing
end
