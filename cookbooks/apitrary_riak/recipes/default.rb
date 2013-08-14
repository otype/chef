#
# Cookbook Name:: apitrary_riak
# Recipe:: default
#
# Copyright 2013, apitrary
#
# All rights reserved - Do Not Redistribute
#

directory "/usr/lib/riak/lib/external" do
  owner "root"
  group "root"
  mode 0755
  not_if {File.exists?("/usr/lib/riak/lib/external")}
end

execute "clone_riak_mapreduce_utils" do
  user "root"
  command "cd /usr/src && git clone https://github.com/whitenode/riak_mapreduce_utils.git"
  notifies :run, "execute[compile_riak_mapreduce_utils]"
  not_if {File.exists?("/usr/src/riak_mapreduce_utils")}
end


execute "compile_riak_mapreduce_utils" do
  user "root"
  command "cd /usr/src/riak_mapreduce_utils && /usr/bin/erlc riak_mapreduce_utils.erl"
  action :nothing
  notifies :run, "execute[move_riak_mapreduce_utils.beam]"
end

execute "move_riak_mapreduce_utils.beam" do
  user "root"
  command "cp /usr/src/riak_mapreduce_utils/riak_mapreduce_utils.beam /usr/lib/riak/lib/external"
  action :nothing
end
