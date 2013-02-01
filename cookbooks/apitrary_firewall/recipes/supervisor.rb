#
# Cookbook Name:: apitrary_firewall
# Recipe:: supervisor
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

# Get all loadbalancers
loadbalancer_nodes = search(:node, "chef_environment:#{node.chef_environment} AND role:loadbalancer")

# Allow connections from loadbalancer
loadbalancer_nodes.each do |lb_node|
  # Allow Nginx
  simple_iptables_rule "system" do
    rule "-p tcp -s #{lb_node['ipaddress']} --dport 9001"
    jump "ACCEPT"
  end
end

# Get all app server nodes IPs
app_server_nodes = search(:node, "chef_environment:#{node.chef_environment} AND role:appserver")

# Allow connections from app server nodes
app_server_nodes.each do |app_node|
  simple_iptables_rule "system" do
    rule "-p tcp -s #{app_node['ipaddress']} --dport 9001"
    jump "ACCEPT"
  end
end

# Allow from all addresses (due to cloudcontrol)
simple_iptables_rule "system" do
  rule "-p tcp --dport 9001"
  jump "ACCEPT"
end
