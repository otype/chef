#
# Cookbook Name:: apitrary_firewall
# Recipe:: web
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

# Get all loadbalancers
railsweb_nodes = search(:node, "chef_environment:#{node.chef_environment} AND role:railsweb")

# Allow connections from loadbalancer
railsweb_nodes.each do |railsweb_node|
  # Allow Nginx
  simple_iptables_rule "system" do
    rule "-p tcp -s #{railsweb_node['ipaddress']} --dport 6379"
    jump "ACCEPT"
  end
end
