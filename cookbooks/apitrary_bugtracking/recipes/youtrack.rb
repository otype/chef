#
# Cookbook Name:: apitrary_bugtracking
# Recipe:: youtrack
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apitrary_bugtracking::default"
include_recipe "user::default"
include_recipe "supervisor"

directory "/home/bugs/youtrack" do
  mode "0755"
  owner "bugs"
  group "bugs"
  action :create
  recursive true
  not_if {File.exists?("/home/bugs/youtrack")}
end

template "/etc/supervisor.d/youtrack.conf" do
  source "supervisor_youtrack.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :run, 'execute[supervisor_youtrack_add]', :immediately
end

execute "supervisor_youtrack_add" do
  user "root"
  command "supervisorctl stop youtrack ; supervisorctl remove youtrack ; supervisorctl reread && supervisorctl add youtrack"
  action :nothing
end
