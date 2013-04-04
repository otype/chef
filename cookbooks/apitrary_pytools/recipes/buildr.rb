#
# Cookbook Name:: apitrary_pytools
# Recipe:: buildr
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "user::default"
include_recipe "supervisor::default"
include_recipe "apitrary_pytools::default"
include_recipe "apitrary_pytools::pytools"
include_recipe "apitrary_pytools::deployr"

user_account 'buildr' do
  comment   'Buildr User'
  home      '/home/buildr'
  shell     '/usr/sbin/nologin'
  not_if {File.exists?("/home/buildr")}
end

#directory "/etc/deployr" do
#  owner "root"
#  group "root"
#  mode 0700
#end
#
#template "/etc/deployr/deployr.conf" do
#  source "deployr.conf.erb"
#  mode 0644
#  owner "root"
#  group "root"
#  notifies :run, 'execute[supervisor_buildr_restart]', :immediately
#end

template "/etc/supervisor/conf.d/buildr.conf" do
  source "supervisor_buildr.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :run, 'execute[supervisor_buildr_add]', :immediately
end

execute "supervisor_buildr_add" do
  user "root"
  command "supervisorctl stop buildr; supervisorctl remove buildr ; supervisorctl reread && supervisorctl add buildr"
  action :nothing
end

execute "supervisor_buildr_restart" do
  user "root"
  command "supervisorctl reread && supervisorctl restart buildr"
  action :nothing
end
