#
# Cookbook Name:: supervisor
# Recipe:: default
#
# Copyright 2013, apitrary
#
# All rights reserved - Do Not Redistribute
#

package "supervisor"

template "/etc/supervisor/supervisord.conf" do
  source "supervisord.conf.erb"
  owner "root"
  group "root"
  mode "644"
end
