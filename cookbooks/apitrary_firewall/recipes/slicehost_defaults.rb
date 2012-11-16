#
# Cookbook Name:: apitrary_firewall
# Recipe:: slicehost_defaults
#
# A set of rules has been taken from following tutorial:
# http://www.techrepublic.com/blog/10things/10-iptables-rules-to-help-secure-your-linux-box/539
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

# Reject packets other than those explicitly allowed
simple_iptables_policy "INPUT" do
  policy "DROP"
end

# Reject packets other than those explicitly allowed
simple_iptables_policy "FORWARD" do
  policy "DROP"
end

# Port-scan rules
simple_iptables_rule "system" do
  rule "-p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j RETURN"
  jump false
end

# Log
simple_iptables_rule "system" do
  rule "--match limit --limit 5/min --jump LOG --log-prefix \"iptables denied: \" --log-level 7"
  jump false
end

# Allow ping
simple_iptables_rule "system" do
  rule "-p icmp -m icmp --icmp-type 8"
  jump "ACCEPT"
end

# Allow all traffic on the loopback device and drop all traffic to 127/8 that doesn't use lo0
simple_iptables_rule "system" do
  rule "-i lo"
  jump "ACCEPT"
end

#
simple_iptables_rule "system" do
  rule "! -i lo -d 127.0.0.0/8"
  jump "REJECT"
end

# Allow any established connections to continue, even
# if they would be in violation of other rules.
simple_iptables_rule "system" do
  rule "-m conntrack --ctstate ESTABLISHED,RELATED"
  jump "ACCEPT"
end