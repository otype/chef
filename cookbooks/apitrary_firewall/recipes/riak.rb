#
# Cookbook Name:: apitrary_firewall
# Recipe:: riak
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

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