#
# Author:: Hans-Gunther Schmidt
# Cookbook Name:: riak
# Recipe:: sysconf
#

template "/etc/default/riak" do
  source "etc_default_riak.erb"
  mode 0644
  owner "root"
  group "root"
end
