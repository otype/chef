#
# Cookbook Name:: apitrary_ssh_keys
# Recipe:: default
#
# Copyright 2013, apitrary
#
# All rights reserved - Do Not Redistribute
#
directory "/home/ubuntu/.ssh" do
  owner "ubuntu"
  mode 0755
  action :create
  not_if {File.exists?("/home/ubuntu/.ssh")}
end

# TODO: Fix this one or find another solution!
# Following not working on OpsWorks nodes due to Chef overwriting this file for OpsWorks
#template "/home/ubuntu/.ssh/config" do
#  source "ssh_config.erb"
#  mode 0644
#  owner "ubuntu"
#  group "ubuntu"
#end

# TODO: Remove if unused
#template "/home/ubuntu/.ssh/live-bitbucket-ro" do
#  source "live-bitbucket-ro.erb"
#  mode 0600
#  owner "ubuntu"
#  group "ubuntu"
#end
#
#template "/home/ubuntu/.ssh/live-bitbucket-ro.pub" do
#  source "live-bitbucket-ro.pub.erb"
#  mode 0644
#  owner "ubuntu"
#  group "ubuntu"
#end

template "/home/ubuntu/.ssh/apitrary-staging-deploy" do
  source "apitrary-staging-deploy.erb"
  mode 0600
  owner "ubuntu"
  group "ubuntu"
end

template "/home/ubuntu/.ssh/apitrary-staging-deploy.pub" do
  source "apitrary-staging-deploy.pub.erb"
  mode 0644
  owner "ubuntu"
  group "ubuntu"
end