#
# Cookbook Name:: ssh
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "openssh-server" do
    action [:install]
end

template "/etc/ssh/sshd_config" do
    source "sshd_config.erb"
    mode 0755
    owner "root"
    group "root"
end

service "openssh" do
    action[:enable,:start]
end
