#
# Cookbook Name:: apitrary_firewall
# Recipe:: web
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

# Get all app server nodes IPs
app_server_nodes = search(:node, "chef_environment:#{node.chef_environment} AND role:appserver")

# Allow connections from app server nodes
app_server_nodes.each do |app_node|
  simple_iptables_rule "system" do
    rule "-p tcp -s #{app_node['ipaddress']} --dport 6379"
    jump "ACCEPT"
  end
end
