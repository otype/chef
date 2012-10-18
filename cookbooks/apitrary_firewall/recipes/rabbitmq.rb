#
# Cookbook Name:: apitrary_firewall
# Recipe:: ssh
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

# Allow RabbitMQ & management console
simple_iptables_rule "system" do
  rule [
           "-p tcp --dport 5672",
           "-p tcp --dport 55672"
       ]
  jump "ACCEPT"
end