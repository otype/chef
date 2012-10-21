#
# Cookbook Name:: apitrary_riak
# Recipe:: default
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

package_uri = "http://s3.amazonaws.com/downloads.basho.com/riak/1.2/1.2.1/debian/6/riak_1.2.1-1_amd64.deb"
package_file = package_uri.split("/").last
package_checksum = "b45550e3b2f6aab64c248abc008c27ba769351098d451c9637fd0f7fbb150f72"
package_version = "1.2.1-1"

group "riak"

user "riak" do
  gid "riak"
  shell "/bin/bash"
  home "/var/lib/riak"
  system true
end

directory "/tmp/riak_pkg" do
  owner "root"
  mode 0755
  action :create
end

remote_file "/tmp/riak_pkg/#{package_file}" do
  source package_uri
  owner "root"
  mode 0644
  checksum package_checksum
  not_if { File.exists?("/tmp/riak_pkg/#{package_file}") }
end

execute "dpkg -i /tmp/riak_pkg/#{package_file}" do
  command "dpkg -i /tmp/riak_pkg/#{package_file}"
  not_if { `dpkg --get-selections riak` != "" }
end

template "/etc/riak/app.config" do
  source "app.config.erb"
  owner "root"
  mode 0644
end

template "/etc/riak/vm.args" do
  source "vm.args.erb"
  owner "root"
  mode 0644
end

service "riak" do
  supports :start => true, :stop => true, :restart => true
  action [ :enable ]
    subscribes :restart, resources(:template => %w(/etc/riak/app.config /etc/riak/vm.args))
end
