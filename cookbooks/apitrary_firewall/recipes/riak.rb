#
# Cookbook Name:: apitrary_firewall
# Recipe:: riak
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

# Get all app server nodes IPs
app_server_nodes = search(:node, "chef_environment:#{node.chef_environment} AND role:appserver")

# Allow connections from app server nodes to Riak nodes
app_server_nodes.each do |app_node|
  simple_iptables_rule "system" do
    rule "-p tcp -s #{app_node['ipaddress']} -m state --state NEW,ESTABLISHED"
    jump "ACCEPT"
  end
end

# Get all riak server nodes IPs
riak_nodes = search(:node, "chef_environment:#{node.chef_environment} AND role:riak-cluster")

# Allow connections from app server nodes to Riak nodes
riak_nodes.each do |riak_node|
  simple_iptables_rule "system" do
    rule "-p tcp -s #{riak_node['ipaddress']} -m state --state NEW,ESTABLISHED"
    jump "ACCEPT"
  end
end

simple_iptables_rule "system" do
  rule [
           "-p tcp --dport 8091",
           "-p tcp --dport 8098"
       ]
  jump "ACCEPT"
end

simple_iptables_rule "system" do
  rule [
           "-p tcp --dport 8081",
           "-p tcp --dport 8087"
       ]
  jump "ACCEPT"
end