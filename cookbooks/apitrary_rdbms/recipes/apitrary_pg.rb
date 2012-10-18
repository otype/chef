#
# Cookbook Name:: apitrary_rdbms
# Recipe:: apitrary_pg
#
# Check the detailed information on:
# https://github.com/opscode-cookbooks/database
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

##create a postgresql database
#postgresql_database 'mr_softie' do
#  connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
#  action :create
#end
#
## create a postgresql database with additional parameters
#postgresql_database 'mr_softie' do
#  connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
#  template 'DEFAULT'
#  encoding 'DEFAULT'
#  tablespace 'DEFAULT'
#  connection_limit '-1'
#  owner 'postgres'
#  action :create
#end
#
#postgresql_connection_info = {:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']}
#
#postgresql_database 'foo' do
#  connection postgresql_connection_info
#  action :create
#end