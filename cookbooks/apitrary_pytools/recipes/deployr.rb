#
# Cookbook Name:: apitrary_pytools
# Recipe:: deployr
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "user::default"
include_recipe "supervisor::default"
include_recipe "apitrary_pytools::default"

user_account 'deployr' do
  comment   'Deployr User'
  home      '/home/deployr'
  shell     '/usr/sbin/nologin'
  not_if {File.exists?("/home/deployr")}
end

execute "pip-install-deployr" do
  #command "pip install --upgrade git+ssh://git@github.com/apitrary/pygenapi.git@#{node[:tagname]}"
  command "pip install --upgrade git+ssh://git@github.com/apitrary/deployr.git"
  user "root"
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
  template "/etc/supervisor/conf.d/deployr_balance.conf" do
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
  template "/etc/supervisor/conf.d/deployr_deploy.conf" do
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
