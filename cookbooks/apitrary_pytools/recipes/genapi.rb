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

#execute "remove deployment dir" do
#  command "rm -rf #{node['apitrary_pytools']['genapi']['deployment_dir']}"
#  user "root"
#  only_if {File.exists?(node['apitrary_pytools']['genapi']['deployment_dir'])}
#end

#git "#{node['apitrary_pytools']['genapi']['deployment_dir']}" do
#  repository "#{node['apitrary_pytools']['genapi']['repo']}"
#  revision "master"
#  #action :sync
#  action :export
#  user "genapi"
#end
#
#execute "pip_install" do
#  user "root"
#  command "cd #{node['apitrary_pytools']['genapi']['deployment_dir']} && python setup.py install"
#end

execute "pip-install-genapi" do
  #command "pip install --upgrade git+ssh://git@github.com/apitrary/pygenapi.git@#{node[:tagname]}"
  command "pip install --upgrade git+ssh://git@github.com/apitrary/pygenapi.git"
  user "root"
  #action :nothing
  #unless node.has_key?("nctest")
  #  notifies :run, "execute[nodecontroller-add]", :immediately
  #end
end
