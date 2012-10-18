#
# Cookbook Name:: base
# Recipe:: service_restarts
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
service "ssh" do
  action :restart
end