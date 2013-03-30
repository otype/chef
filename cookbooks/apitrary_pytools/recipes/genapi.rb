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

execute "pip-install-genapi" do
  #command "pip install --upgrade git+ssh://git@github.com/apitrary/pygenapi.git@#{node[:tagname]}"
  command "pip install --upgrade git+ssh://git@github.com/apitrary/pygenapi.git"
  user "root"
end
