#
# Cookbook Name:: ssh
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "openssh-server"

template "/etc/ssh/sshd_config" do
  source "sshd_config.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[ssh]", :immediately
  notifies :enable, "service[ssh]"
end

service "ssh" do
  action :nothing
end
