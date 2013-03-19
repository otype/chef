#
# Cookbook Name:: apitrary_base
# Recipe:: default
#
# Copyright 2013, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "user::default"

# Don't USE this ... it messes up the root ssh config
include_recipe "apitrary_ssh_keys::default"

##%w(python-dev libcurl4-openssl-dev supervisor).each do |pkg|
#%w(python-dev supervisor).each do |pkg|
#  package pkg do
#    action :install
#  end
#end

#user_account 'devops' do
#  comment   'DevOps User'
#  home      '/home/devops'
#  shell     '/usr/sbin/nologin'
#  not_if {File.exists?("/home/devops")}
#end

# TODO: Put all necessary magic in here!