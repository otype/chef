#
# Cookbook Name:: apitrary_firewall
# Recipe:: postgres
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

simple_iptables_rule "system" do
  rule "-p tcp --dport 5432"
  jump "ACCEPT"
end