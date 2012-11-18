#
# Cookbook Name:: apitrary_firewall
# Recipe:: supervisor
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

# Allow youtrack
simple_iptables_rule "system" do
  rule [
           "-p tcp --dport 8000",   # youtrack
           "-p tcp --dport 8111"    # teamcity
  ]
  jump "ACCEPT"
end
