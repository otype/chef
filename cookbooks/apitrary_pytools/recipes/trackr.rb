#
# Cookbook Name:: apitrary_pytools
# Recipe:: trackr
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apitrary_pytools::default"
include_recipe "supervisor::default"
include_recipe "apitrary_pytools::genapi"

user_account 'trackr' do
  comment   'Trackr User'
  home      '/home/trackr'
  shell     '/usr/sbin/nologin'
  not_if {File.exists?("/home/trackr")}
end

template "/etc/supervisor/conf.d/trackr.conf" do
  source "supervisor_trackr.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :run, 'execute[supervisor_trackr_add]', :immediately
end

execute "supervisor_trackr_add" do
  user "root"
  command "supervisorctl stop trackr ; supervisorctl remove trackr ; supervisorctl reread && supervisorctl add trackr"
  action :nothing
end

