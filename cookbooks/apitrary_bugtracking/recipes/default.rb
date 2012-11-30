#
# Cookbook Name:: apitrary_bugtracking
# Recipe:: default
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "user::default"

%w( openjdk-6-jdk ).each do |pkg|
  package pkg do
    action :install
  end
end

user_account 'bugs' do
  comment   'Bug tracking User'
  home      '/home/bugs'
  shell     '/usr/sbin/nologin'
  not_if {File.exists?("/home/bugs")}
end
