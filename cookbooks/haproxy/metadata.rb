name              "cookbooks.haproxy"
maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs and configures cookbooks.haproxy"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.2.0"

recipe "cookbooks.haproxy", "Installs and configures cookbooks.haproxy"
recipe "cookbooks.haproxy::app_lb", "Installs and configures cookbooks.haproxy by searching for nodes of a particular role"

%w{ debian ubuntu }.each do |os|
  supports os
end

depends           "cpu", ">= 0.2.0"
