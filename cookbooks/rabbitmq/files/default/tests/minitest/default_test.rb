#
# Copyright 2012, Opscode, Inc.
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

require File.expand_path('../support/helpers', __FILE__)

describe "cookbooks.rabbitmq::default" do
  include Helpers::RabbitMQ

  it 'uses the cookbooks.rabbitmq cookbooks.apt source on debian family' do
    unless node['platform_family'] == 'debian'
      skip "Only applicable on Debian family"
    end

    file("/etc/cookbooks.apt/sources.list.d/cookbooks.rabbitmq-source.list").must_exist
  end

  it 'installs the package from downloaded rpm on rhel/fedora family' do
    unless node['platform_family'] == 'rhel' || node['platform_family'] == 'fedora'
      skip "Only applicable on RHEL/Fedora family"
    end

    rpm_path = "#{Chef::Config[:file_cache_path]}/cookbooks.rabbitmq-server-#{node['cookbooks.rabbitmq']['version']}-1.noarch.rpm"

    file(rpm_path).must_exist
  end

  it 'installs the cookbooks.rabbitmq-server package' do
    package("cookbooks.rabbitmq-server").must_be_installed
  end

  it 'enables the cookbooks.rabbitmq-server service' do
    service("cookbooks.rabbitmq-server").must_be_enabled
  end

  it 'starts the cookbooks.rabbitmq-server service' do
    service("cookbooks.rabbitmq-server").must_be_running
  end

  it 'accepts AMQP connections' do
    require 'bunny'
    b = Bunny.new( :host => "localhost",
                   :port => 5672,
                   :user => node['cookbooks.rabbitmq']['default_user'],
                   :pass => node['cookbooks.rabbitmq']['default_pass'] )
    b.start
    b.stop
  end
end
