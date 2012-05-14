#
# Cookbook Name:: base
# Recipe:: create_users
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "htop"
package "sudo"

template "/root/create_user.sh" do
  source "create_user.sh.erb"
  mode 0700
  owner "root"
  group "root"
  notifies :run, resources(:execute => "create-user"), :immediately
  #notifies :run, "execute[create-user]", :immediately
end

execute "create-user" do
  command "/root/create_user.sh"
  not_if { ::File.exists?("/home/hgschmidt") }
  action :nothing
end
