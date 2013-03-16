#
# Cookbook Name:: apitrary_base
# Recipe:: testing
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

execute "testing_chef_opsworks" do
  command "touch /root/testing1 && touch /home/ubuntu/testing2"
  action :run
end
