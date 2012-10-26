#
# Cookbook Name:: apitrary_pytools
# Recipe:: default
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "user::default"

user_account 'deployr' do
  comment   'Deployr User'
  home      '/home/deployr'
  shell     '/usr/sbin/nologin'
end