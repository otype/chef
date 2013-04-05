#
# Cookbook Name:: apitrary_pytools
# Recipe:: pytools
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "user::default"
include_recipe "supervisor::default"
include_recipe "apitrary_pytools::default"

user_account 'pytools' do
  comment   'PyTools User'
  home      '/home/pytools'
  shell     '/usr/sbin/nologin'
  not_if {File.exists?("/home/pytools")}
end

execute "pip-install-pytools" do
  #command "pip install --upgrade git+ssh://git@github.com/apitrary/pytools.git@#{node[:tagname]}"
  command "pip install git+ssh://git@github.com/apitrary/pytools.git"
  user "root"
  not_if {File.exists?("/usr/local/bin/buildr.py")}
end
