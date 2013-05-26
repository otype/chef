#
# Cookbook Name:: apitrary_haproxy
# Recipe:: default
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
include_recipe "haproxy::default"

%w{libcurl4-openssl-dev build-essential libpcre3-dev libssl0.9.8}.each do |pkg|
  package pkg
end


haproxy_config_installed = `cat /etc/haproxy/haproxy.cfg | grep "# REMOVE THIS LINE HERE, THEN RESTART chef-client"`

directory "/var/chroot/haproxy" do
  mode "0755"
  owner "root"
  group "root"
  action :create
  recursive true
  not_if {File.exists?("/var/chroot/haproxy")}
end

# We don't run all this if we already have a generated config by haproxy-config.py!
if haproxy_config_installed.empty?

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

  %w{frontends/http_proxy listen/admin frontends/riak_rest backends/riak_rest_backend backends/riak_protocol_buffer_backend frontends/riak_protocol_buffer}.each do |dir|
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

  template "/etc/haproxy/backends/riak_rest_backend/100-riak_rest_backend" do
    source "backends-100-riak-rest-backend.erb"
    owner "root"
    group "root"
    mode 0644
  end

  template "/etc/haproxy/backends/riak_protocol_buffer_backend/100-riak_protocol_buffers_backend" do
    source "backends-100-riak-protocol-buffer-backend.erb"
    owner "root"
    group "root"
    mode 0644
  end

  template "/etc/haproxy/frontends/riak_rest/10-riak_rest" do
    source "frontends-10-riak-rest.erb"
    owner "root"
    group "root"
    mode 0644
  end

  template "/etc/haproxy/frontends/riak_protocol_buffer/10-riak_protocol_buffer" do
    source "frontends-10-riak-protocol-buffer.erb"
    owner "root"
    group "root"
    mode 0644
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