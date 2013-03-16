name              "cookbooks.rabbitmq"
maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs and configures RabbitMQ server"
version           "1.8.0"
recipe            "cookbooks.rabbitmq", "Install and configure RabbitMQ"
recipe            "cookbooks.rabbitmq::cluster", "Set up RabbitMQ clustering."
depends           "cookbooks.apt", ">= 1.4.4"
depends           "yum", ">= 0.5.0"
depends           "erlang", ">= 0.9"

%w{ubuntu debian redhat centos scientific amazon fedora oracle smartos}.each do |os|
  supports os
end

attribute "cookbooks.rabbitmq",
  :display_name => "RabbitMQ",
  :description => "Hash of RabbitMQ attributes",
  :type => "hash"

attribute "cookbooks.rabbitmq/nodename",
  :display_name => "RabbitMQ Erlang node name",
  :description => "The Erlang node name for this server.",
  :default => "node['hostname']"

attribute "cookbooks.rabbitmq/address",
  :display_name => "RabbitMQ server IP address",
  :description => "IP address to bind."

attribute "cookbooks.rabbitmq/port",
  :display_name => "RabbitMQ server port",
  :description => "TCP port to bind."

attribute "cookbooks.rabbitmq/config",
  :display_name => "RabbitMQ config file to load",
  :description => "Path to the cookbooks.rabbitmq.config file, if any."

attribute "cookbooks.rabbitmq/logdir",
  :display_name => "RabbitMQ log directory",
  :description => "Path to the directory for log files."

attribute "cookbooks.rabbitmq/mnesiadir",
  :display_name => "RabbitMQ Mnesia database directory",
  :description => "Path to the directory for Mnesia database files."

attribute "cookbooks.rabbitmq/cluster",
  :display_name => "RabbitMQ clustering",
  :description => "Whether to activate clustering.",
  :default => "no"

attribute "cookbooks.rabbitmq/cluster_config",
  :display_name => "RabbitMQ clustering configuration file",
  :description => "Path to the clustering configuration file, if cluster is yes.",
  :default => "/etc/cookbooks.rabbitmq/rabbitmq_cluster.config"

attribute "cookbooks.rabbitmq/cluster_disk_nodes",
  :display_name => "RabbitMQ cluster disk nodes",
  :description => "Array of member Erlang nodenames for the disk-based storage nodes in the cluster.",
  :default => [],
  :type => "array"

attribute "cookbooks.rabbitmq/erlang_cookie",
  :display_name => "RabbitMQ Erlang cookie",
  :description => "Access cookie for clustering nodes.  There is no default."
