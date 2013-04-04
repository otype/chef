#
# Cookbook Name:: apitrary_pytools
# Recipe:: default
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "supervisor::default"

%w{libcurl4-openssl-dev protobuf-compiler}.each do |pkg|
  package pkg
end

directory "/root/.ssh" do
  owner "root"
  mode 0755
  action :create
  not_if {File.exists?("/root/.ssh")}
end

template "/root/.ssh/config" do
  source "ssh_config.erb"
  mode 0644
  owner "root"
  group "root"
end

template "/root/.ssh/live-bitbucket-ro" do
  source "live-bitbucket-ro.erb"
  mode 0600
  owner "root"
  group "root"
end

template "/root/.ssh/live-bitbucket-ro.pub" do
  source "live-bitbucket-ro.pub.erb"
  mode 0644
  owner "root"
  group "root"
end

template "/root/.ssh/apitrary-staging-deploy" do
  source "apitrary-staging-deploy.erb"
  mode 0600
  owner "root"
  group "root"
end

template "/root/.ssh/apitrary-staging-deploy.pub" do
  source "apitrary-staging-deploy.pub.erb"
  mode 0644
  owner "root"
  group "root"
end