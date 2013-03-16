# being nil, the cookbooks.rabbitmq defaults will be used
default['cookbooks.rabbitmq']['nodename']  = nil
default['cookbooks.rabbitmq']['address']  = nil
default['cookbooks.rabbitmq']['port']  = nil
default['cookbooks.rabbitmq']['config'] = nil
default['cookbooks.rabbitmq']['logdir'] = nil
default['cookbooks.rabbitmq']['mnesiadir'] = nil

default['cookbooks.rabbitmq']['service_name'] = 'cookbooks.rabbitmq-server'

# RabbitMQ version to install for "redhat", "centos", "scientific", and "amazon".
default['cookbooks.rabbitmq']['version'] = '2.8.4'
# Override this if you have a yum repo with cookbooks.rabbitmq available.
default['cookbooks.rabbitmq']['use_yum'] = false
# Override this if you do not want to use an cookbooks.apt repo
default['cookbooks.rabbitmq']['use_apt'] = true
# The distro versions may be more stable and have back-ported patches
default['cookbooks.rabbitmq']['use_distro_version'] = false

# config file location
# http://www.cookbooks.rabbitmq.com/configure.html#define-environment-variables
# "The .config extension is automatically appended by the Erlang runtime."
default['cookbooks.rabbitmq']['config_root'] = "/etc/cookbooks.rabbitmq"
default['cookbooks.rabbitmq']['config'] = "/etc/cookbooks.rabbitmq/cookbooks.rabbitmq"
default['cookbooks.rabbitmq']['erlang_cookie_path'] = '/var/lib/cookbooks.rabbitmq/.erlang.cookie'

# cookbooks.rabbitmq.config defaults
default['cookbooks.rabbitmq']['default_user'] = 'guest'
default['cookbooks.rabbitmq']['default_pass'] = 'guest'

#clustering
default['cookbooks.rabbitmq']['cluster'] = false
default['cookbooks.rabbitmq']['cluster_disk_nodes'] = []
default['cookbooks.rabbitmq']['erlang_cookie'] = 'AnyAlphaNumericStringWillDo'

# resource usage
default['cookbooks.rabbitmq']['disk_free_limit_relative'] = nil
default['cookbooks.rabbitmq']['vm_memory_high_watermark'] = nil

#ssl
default['cookbooks.rabbitmq']['ssl'] = false
default['cookbooks.rabbitmq']['ssl_port'] = 5671
default['cookbooks.rabbitmq']['ssl_cacert'] = '/path/to/cacert.pem'
default['cookbooks.rabbitmq']['ssl_cert'] = '/path/to/cert.pem'
default['cookbooks.rabbitmq']['ssl_key'] = '/path/to/key.pem'

# SmartOS-specific defaults
if node[:platform] == 'smartos'
  default['cookbooks.rabbitmq']['service_name'] = 'cookbooks.rabbitmq'
  default['cookbooks.rabbitmq']['config_root'] = '/opt/local/etc/cookbooks.rabbitmq'
  default['cookbooks.rabbitmq']['config'] = '/opt/local/etc/cookbooks.rabbitmq/cookbooks.rabbitmq'
  default['cookbooks.rabbitmq']['erlang_cookie_path'] = '/var/db/cookbooks.rabbitmq/.erlang.cookie'
end
