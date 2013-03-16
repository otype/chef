#
# Cookbook Name:: cookbooks.apt
# Recipe:: default
#
# Copyright 2008-2011, Opscode, Inc.
# Copyright 2009, Bryan McLellan <btm@loftninjas.org>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Run cookbooks.apt-get update to create the stamp file
execute "cookbooks.apt-get-update" do
  command "cookbooks.apt-get update"
  ignore_failure true
  not_if do ::File.exists?('/var/lib/cookbooks.apt/periodic/update-success-stamp') end
end

# For other recipes to call to force an update
execute "cookbooks.apt-get update" do
  command "cookbooks.apt-get update"
  ignore_failure true
  action :nothing
end

# Automatically remove packages that are no longer needed for dependencies
execute "cookbooks.apt-get autoremove" do
  command "cookbooks.apt-get -y autoremove"
  action :nothing
end

# Automatically remove .deb files for packages no longer on your system
execute "cookbooks.apt-get autoclean" do
  command "cookbooks.apt-get -y autoclean"
  action :nothing
end

# provides /var/lib/cookbooks.apt/periodic/update-success-stamp on cookbooks.apt-get update
package "update-notifier-common" do
  notifies :run, resources(:execute => "cookbooks.apt-get-update"), :immediately
end

execute "cookbooks.apt-get-update-periodic" do
  command "cookbooks.apt-get update"
  ignore_failure true
  only_if do
    ::File.exists?('/var/lib/cookbooks.apt/periodic/update-success-stamp') &&
    ::File.mtime('/var/lib/cookbooks.apt/periodic/update-success-stamp') < Time.now - 86400
  end
end

%w{/var/cache/local /var/cache/local/preseeding}.each do |dirname|
  directory dirname do
    owner "root"
    group "root"
    mode  00755
    action :create
  end
end
