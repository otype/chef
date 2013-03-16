name              "cookbooks.supervisor"
maintainer        "Noah Kantrowitz"
maintainer_email  "noah@opscode.com"
license           "Apache 2.0"
description       "Installs cookbooks.supervisor and provides resources to configure services"
version           "0.4.0"

recipe "cookbooks.supervisor", "Installs and configures supervisord"

depends "cookbooks.python"

%w{ ubuntu debian }.each do |os|
  supports os
end
