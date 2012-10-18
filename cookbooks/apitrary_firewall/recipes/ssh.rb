#
# Cookbook Name:: apitrary_firewall
# Recipe:: ssh
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

# Allow SSH
simple_iptables_rule "system" do
  rule "-p tcp -m state --state NEW --dport 22022"
  jump "ACCEPT"
end