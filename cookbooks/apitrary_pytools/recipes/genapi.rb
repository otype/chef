#
# Cookbook Name:: apitrary_pytools
# Recipe:: default
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "user::default"

user_account 'genapi' do
  comment   'Genapi User'
  home      '/home/genapi'
  shell     '/usr/sbin/nologin'
end