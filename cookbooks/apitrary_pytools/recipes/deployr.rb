#
# Cookbook Name:: apitrary_pytools
# Recipe:: default
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "user::default"
include_recipe "supervisor"

user_account 'deployr' do
  comment   'Deployr User'
  home      '/home/deployr'
  shell     '/usr/sbin/nologin'
  not_if {File.exists?("/home/deployr")}
end

template "/home/deployr/.ssh/config" do
  source "deployr_ssh_config.erb"
  mode 0644
  owner "deployr"
  group "deployr"
end

template "/home/deployr/.ssh/live-bitbucket-ro" do
  source "live-bitbucket-ro.erb"
  mode 0600
  owner "deployr"
  group "deployr"
end

template "/home/deployr/.ssh/live-bitbucket-ro.pub" do
  source "live-bitbucket-ro.pub.erb"
  mode 0644
  owner "deployr"
  group "deployr"
end

git "#{node['apitrary_pytools']['deployr']['deployment_dir']}" do
  repository "#{node['apitrary_pytools']['deployr']['repo']}"
  #revision "master"
  revision "0.9.6-p5"
  action :sync
  #action :export
  user "deployr"
end

execute "pip_install" do
  user "root"
  command "cd #{node['apitrary_pytools']['deployr']['deployment_dir']} && python setup.py install"
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
end

template "/etc/supervisor.d/deployr.conf" do
  source "supervisor_deployr.conf.erb"
  mode 0644
  owner "root"
  group "root"
  variables(
      :deployr_mode => "deploy"
  )
end

execute "add deployr to supervisor" do
  user "root"
  command "supervisorctl reread && supervisorctl add deployr"
  not_if {"supervisorctl status deployr | grep deployr"}
end

execute "restart deployr in supervisor" do
  user "root"
  command "supervisorctl reread && supervisorctl restart deployr"
end
