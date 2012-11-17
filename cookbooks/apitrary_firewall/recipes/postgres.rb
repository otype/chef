#
# Cookbook Name:: apitrary_firewall
# Recipe:: postgres
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

railsweb_nodes = search(:node, "chef_environment:#{node.chef_environment} AND role:railsweb")

# Allow connections from loadbalancer
railsweb_nodes.each do |railsweb_node|
  simple_iptables_rule "system" do
    rule "-p tcp -s #{railsweb_node['ipaddress']} --dport 5432"
    jump "ACCEPT"
  end
end
