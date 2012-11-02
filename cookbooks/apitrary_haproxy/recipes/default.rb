#
# Cookbook Name:: apitrary_haproxy
# Recipe:: default
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "haproxy::default"

haproxy_config_installed = `cat /etc/haproxy/haproxy.cfg | grep "# This file is generated. All changes are overwritten"`

# We don't run all this if we already have a generated config by haproxy-config.py!
if haproxy_config_installed.empty?

  # We need this temporarily before we switch our old LIVE apitrary.com to the new server.
  web_nodes = search(:node, "chef_environment:#{node.chef_environment} AND role:railsweb")
  web_acl = 'www'
  if node.chef_environment == 'LIVE'
    web_acl = 'www2'
  end

  template "/usr/local/sbin/haproxy-config.py" do
    source "haproxy-config.py.erb"
    owner "root"
    group "root"
    mode 0755
  end

  %w{global defaults frontends listen backends}.each do |dir|
    directory "/etc/haproxy/#{dir}" do
      mode "0755"
      owner "root"
      group "root"
      action :create
      recursive true
    end
  end

  %w{frontends/http_proxy backends/launchpad_cluster backends/www_cluster listen/admin}.each do |dir|
    directory "/etc/haproxy/#{dir}" do
      mode "0755"
      owner "root"
      group "root"
      action :create
      recursive true
    end
  end

  template "/etc/haproxy/global/00-base" do
    source "global-00-base.erb"
    owner "root"
    group "root"
    mode 0644
  end

  template "/etc/haproxy/defaults/00-base" do
    source "defaults-00-base.erb"
    owner "root"
    group "root"
    mode 0644
  end

  if node["haproxy"]["enable_admin"]
    template "/etc/haproxy/listen/00-base" do
      source "listen-00-base.erb"
      owner "root"
      group "root"
      mode 0644
    end
  end

  template "/etc/haproxy/frontends/http_proxy/00-base" do
    source "frontends-00-base.erb"
    owner "root"
    group "root"
    mode 0644
  end

  template "/etc/haproxy/frontends/http_proxy/10-www" do
    source "frontends-tpl.erb"
    owner "root"
    group "root"
    mode 0644
    variables(:webacl => web_acl)
  end

  template "/etc/haproxy/frontends/http_proxy/20-launchpad" do
    source "frontends-tpl.erb"
    owner "root"
    group "root"
    mode 0644
    variables(:webacl => "launchpad")
  end

  template "/etc/haproxy/backends/launchpad_cluster/00-base" do
    source "backends-tpl.erb"
    owner "root"
    group "root"
    mode 0644
    variables(
        :webacl => "launchpad",
        :webnodes => web_nodes
    )
  end

  template "/etc/haproxy/backends/www_cluster/00-base" do
    source "backends-tpl.erb"
    owner "root"
    group "root"
    mode 0644
    variables(
        :webacl => web_acl,
        :webnodes => web_nodes
    )
  end

  service "haproxy" do
    supports :restart => true, :status => true, :reload => true
    action [:enable, :start]
  end

  template "/etc/init.d/haproxy" do
    source "haproxy-init.erb"
    owner "root"
    group "root"
    mode 0755
    notifies :restart, "service[haproxy]"
  end
end