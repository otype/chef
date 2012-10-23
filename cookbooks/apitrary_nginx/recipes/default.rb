#
# Cookbook Name:: apitrary_nginx
# Recipe:: default
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "build-essential"

%w( wget libpcre3-dev libcurl3-gnutls-dev).each do |pkg|
  package pkg do
    action :install
  end
end

%w( passenger).each do |g|
  gem_package g do
    action :install
    gem_binary('/usr/local/bin/gem')
  end
end
