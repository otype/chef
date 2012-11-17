#
# Cookbook Name:: apitrary_firewall
# Recipe:: supervisor
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

# We need this temporarily before we switch our old LIVE apitrary.com to the new server.
loadbalancer_nodes = search(:node, "chef_environment:#{node.chef_environment} AND role:loadbalancer")

# Allow connections from loadbalancer to app server
loadbalancer_nodes.each do |lb_node|
  # Allow Nginx
  simple_iptables_rule "system" do
    rule "-p tcp -s #{lb_node['ipaddress']} --dport 8080"
    jump "ACCEPT"
  end
end
