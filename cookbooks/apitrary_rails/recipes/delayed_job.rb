#
# Cookbook Name:: apitrary_rails
# Recipe:: delayed_job
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "supervisor"

template "/etc/supervisor.d/delayed_job.conf" do
  source "supervisor_delayed_job.conf.erb"
  mode 0644
  owner "root"
  group "root"
  variables(
      :rails_env => node.chef_environment == "DEV" ? "staging" : "production"
  )
  notifies :run, 'execute[restart delayed_job in supervisor]', :immediately
end

execute "add delayed_job to supervisor" do
  user "root"
  command "supervisorctl reread && supervisorctl add delayed_job"
  not_if {"supervisorctl status delayed_job | grep delayed_job"}
end

execute "restart delayed_job in supervisor" do
  user "root"
  command "supervisorctl reread && supervisorctl restart delayed_job"
  action :nothing
end
