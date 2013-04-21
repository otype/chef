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

user_account 'balancr' do
  comment   'Balancr User'
  home      '/home/balancr'
  shell     '/usr/sbin/nologin'
  not_if {File.exists?("/home/balancr")}
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
  notifies :run, 'execute[supervisor_balancr_restart]', :immediately
end

template "/etc/supervisor/conf.d/balancr.conf" do
  source "supervisor_balancr.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :run, 'execute[supervisor_balancr_add]', :immediately
end

execute "supervisor_balancr_add" do
  user "root"
  command "supervisorctl stop balancr; supervisorctl remove balancr ; supervisorctl reread && supervisorctl add balancr"
  action :nothing
end

execute "supervisor_balancr_restart" do
  user "root"
  command "supervisorctl reread && supervisorctl restart balancr"
  action :nothing
end
