#
# Cookbook Name:: apitrary_pytools
# Recipe:: genapi
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "user::default"
include_recipe "supervisor"

user_account 'genapi' do
  comment   'Genapi User'
  home      '/home/genapi'
  shell     '/usr/sbin/nologin'
  not_if {File.exists?("/home/genapi")}
end

template "/home/genapi/.ssh/config" do
  source "deployr_ssh_config.erb"
  mode 0644
  owner "genapi"
  group "genapi"
end

template "/home/genapi/.ssh/live-bitbucket-ro" do
  source "live-bitbucket-ro.erb"
  mode 0600
  owner "genapi"
  group "genapi"
end

template "/home/genapi/.ssh/live-bitbucket-ro.pub" do
  source "live-bitbucket-ro.pub.erb"
  mode 0644
  owner "genapi"
  group "genapi"
end

template "/home/genapi/.ssh/apitrary-staging-deploy" do
  source "apitrary-staging-deploy.erb"
  mode 0600
  owner "genapi"
  group "genapi"
end

template "/home/genapi/.ssh/apitrary-staging-deploy.pub" do
  source "apitrary-staging-deploy.pub.erb"
  mode 0644
  owner "genapi"
  group "genapi"
end

execute "remove deployment dir" do
  command "rm -rf #{node['apitrary_pytools']['genapi']['deployment_dir']}"
  user "root"
  only_if {File.exists?(node['apitrary_pytools']['genapi']['deployment_dir'])}
end

git "#{node['apitrary_pytools']['genapi']['deployment_dir']}" do
  repository "#{node['apitrary_pytools']['genapi']['repo']}"
  revision "master"
  #action :sync
  action :export
  user "genapi"
end

execute "pip_install" do
  user "root"
  command "cd #{node['apitrary_pytools']['genapi']['deployment_dir']} && python setup.py install"
end
