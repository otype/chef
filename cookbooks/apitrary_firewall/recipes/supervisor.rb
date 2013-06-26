#
# Cookbook Name:: apitrary_firewall
# Recipe:: supervisor
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

# Allow connections from buildr to app server
buildr_nodes = search(:node, "chef_environment:#{node.chef_environment} AND role:buildrserver")
buildr_nodes.each do |buildr_node|
  simple_iptables_rule "system" do
    rule "-p tcp -s #{buildr_node['ipaddress']} --dport 9001"
    jump "ACCEPT"
  end
end
