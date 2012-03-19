#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "htop"
package "sudo"

template "/root/create_user.sh" do
    source "create_user.sh.erb"
    mode 0755
    owner "root"
    group "root"
end

execute "create-user" do
  command "/root/create_user.sh"
  not_if { ::File.exists?("/home/hgschmidt") }
end
