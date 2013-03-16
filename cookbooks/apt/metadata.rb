name              "cookbooks.apt"
maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Configures cookbooks.apt and cookbooks.apt services and LWRPs for managing cookbooks.apt repositories and preferences"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.9.0"
recipe            "cookbooks.apt", "Runs cookbooks.apt-get update during compile phase and sets up preseed directories"
recipe            "cookbooks.apt::cacher-ng", "Set up an cookbooks.apt-cacher-ng caching proxy"
recipe            "cookbooks.apt::cacher-client", "Client for the cookbooks.apt::cacher-ng caching proxy"

%w{ ubuntu debian }.each do |os|
  supports os
end
