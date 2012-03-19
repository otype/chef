#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "iptables"

template "/etc/iptables.test.rules" do
  source "iptables.test.rules.erb"
  owner "root"
  group "root"
end

execute "iptables-restore" do
  command "iptables-restore < /etc/iptables.test.rules"
  user "root"
  group "root"
  action :run
  notifies :run, "execute[iptables-save]", :immediately
end

execute "iptables-save" do
  command "iptables-save > /etc/iptables.up.rules"
  user "root"
  group "root"
  action :nothing
end

execute "network-interfaces" do
  command "echo 'pre-up iptables-restore < /etc/iptables.up.rules' >> /etc/network/interfaces"
  user "root"
  group "root"
  action :run
  only_if do
    lines = `cat /etc/network/interfaces | grep iptables-restore`
    Chef::Log.info "Lines found? -> #{lines.empty?}"
    lines.empty?
  end
end
