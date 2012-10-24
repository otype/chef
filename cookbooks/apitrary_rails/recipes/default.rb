#
# Cookbook Name:: apitrary_rails
# Recipe:: default
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "user::default"
include_recipe "carlo-chef-ruby1.9::default"
include_recipe "apitrary_passenger_nginx::default"
include_recipe "apitrary_nodejs::default"

%w(rails).each do |g|
  gem_package g do
    action :install
    gem_binary('/usr/local/bin/gem')
  end
end

user_account 'rails' do
  comment   'Rails Web User'
  home      '/home/rails'
  shell     '/bin/bash'
  ssh_keys  ['ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3OIW1TlIAT8O9uxkWV3e8pHcXYZQaLTH5WhqDjyeFR2RepjzjZEjhiHN7lN2jVuFav6bEtywPk6MJgYlJZTfqTB6k6Y2VzeDz3ukxF46+a9v+FYKqLjVMB4hfEDjHq39/+uwp3TtniRIcWMtiU1biF8jbz+Ob2dMUoq+fZ4xmqYtlMbG44lhs2Htp33JYro57OdX6AfsP+roZuPRcOW4m2YfnwNvRbWNmU9p9WO94bqfbCPELgK0I8EI5LMM6js1o77DBQIvh7uN66JjmG3D5rAWjeaX5cXqgw5gbk5s8nn7DTOGbBqKlwP0fyLdxX9HOWod2mGJ9U9G22MTC6iIh+WODeMsguPTI1T+vsPxEkSNrXAfNVcDrPlUFNgwhuJvkVvRT/z07OQz9+Ha9u3IWKENXGGm2r0A/KnthdN/cxfYuls8tpBrQffItFN0qLQ1T6pJJJKpQXvPQ6vaX/ohjT39ySV+vxD+VUIdp3uMl54ZPveBVEiQIecRZStKi7H1meUn7Lo9AK3AtqeYMTMTLloIcnwDIoogLEHbkyG4rsZ7nhgDxXqlcbXIjq66QjSaoi3NE6GtaWooUTq5FNRap8bJoQlpr8w8N57z3TnBafuqRscUHo/3CY9tMTvLQs9gPaM+xnZRDI7E9O0lgQozKGhD6CVlNAgBKuV3Ir6i9pw== devops@vm6']
end
