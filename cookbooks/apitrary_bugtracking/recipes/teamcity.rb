#
# Cookbook Name:: apitrary_bugtracking
# Recipe:: teamcity
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apitrary_bugtracking::default"
include_recipe "user::default"
include_recipe "supervisor"

directory "/home/bugs/teamcity" do
  mode "0755"
  owner "bugs"
  group "bugs"
  action :create
  recursive true
  not_if {File.exists?("/home/bugs/teamcity")}
end

execute "start_teamcity" do
  user "bugs"
  command "/home/bugs/teamcity/bin/teamcity-server.sh start"
  not_if { `ps aux | grep teamcity | grep catalina` }
end
