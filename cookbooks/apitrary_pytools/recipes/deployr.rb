#
# Cookbook Name:: apitrary_pytools
# Recipe:: deployr
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "user::default"
include_recipe "supervisor"

user_account 'deployr' do
  comment   'Deployr User'
  home      '/home/deployr'
  shell     '/usr/sbin/nologin'
  not_if {File.exists?("/home/deployr")}
end

template "/home/deployr/.ssh/config" do
  source "deployr_ssh_config.erb"
  mode 0644
  owner "deployr"
  group "deployr"
end

template "/home/deployr/.ssh/live-bitbucket-ro" do
  source "live-bitbucket-ro.erb"
  mode 0600
  owner "deployr"
  group "deployr"
end

template "/home/deployr/.ssh/live-bitbucket-ro.pub" do
  source "live-bitbucket-ro.pub.erb"
  mode 0644
  owner "deployr"
  group "deployr"
end

template "/home/deployr/.ssh/apitrary-staging-deploy" do
  source "apitrary-staging-deploy.erb"
  mode 0600
  owner "deployr"
  group "deployr"
end

template "/home/deployr/.ssh/apitrary-staging-deploy.pub" do
  source "apitrary-staging-deploy.pub.erb"
  mode 0644
  owner "deployr"
  group "deployr"
end

execute "remove deployment dir" do
  command "rm -rf #{node['apitrary_pytools']['deployr']['deployment_dir']}"
  user "root"
  only_if {File.exists?(node['apitrary_pytools']['deployr']['deployment_dir'])}
end

git "#{node['apitrary_pytools']['deployr']['deployment_dir']}" do
  repository "#{node['apitrary_pytools']['deployr']['repo']}"
  revision "master"
  #action :sync
  action :export
  user "deployr"
end

execute "pip_install" do
  user "root"
  command "cd #{node['apitrary_pytools']['deployr']['deployment_dir']} && python setup.py install"
end

directory "/etc/deployr" do
  owner "root"
  group "root"
  mode 0700
end

template "/etc/deployr/deployr.conf" do
  source "deployr.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :run, 'execute[supervisor_deployr_add]', :immediately
end

if node['roles'].include?("loadbalancer")
  template "/etc/supervisor.d/deployr_balance.conf" do
    source "supervisor_deployr.conf.erb"
    mode 0644
    owner "root"
    group "root"
    variables(
        :deployr_mode => node['deployr']['deploy_mode']
    )
    notifies :run, 'execute[supervisor_deployr_add]', :immediately
  end
  execute "supervisor_deployr_add" do
    user "root"
    command "supervisorctl stop deployr_balance ; supervisorctl remove deployr_balance ; supervisorctl reread && supervisorctl add deployr_balance"
    action :nothing
  end
else
  template "/etc/supervisor.d/deployr_deploy.conf" do
    source "supervisor_deployr.conf.erb"
    mode 0644
    owner "root"
    group "root"
    variables(
        :deployr_mode => node['deployr']['deploy_mode']
    )
    notifies :run, 'execute[supervisor_deployr_add]', :immediately
  end
  execute "supervisor_deployr_add" do
    user "root"
    command "supervisorctl stop deployr_deploy ; supervisorctl remove deployr_deploy ; supervisorctl reread && supervisorctl add deployr_deploy"
    action :nothing
  end
end

execute "supervisor_deployr_restart" do
  user "root"
  command "supervisorctl reread && supervisorctl restart deployr"
  action :nothing
end
