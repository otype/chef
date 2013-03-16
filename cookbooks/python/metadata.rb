name              "cookbooks.python"
maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs Python, pip and virtualenv. Includes LWRPs for managing Python packages with `pip` and `virtualenv` isolated Python environments."
version           "1.2.2"

depends           "build-essential"
depends           "yum"

recipe "cookbooks.python", "Installs cookbooks.python, pip, and virtualenv"
recipe "cookbooks.python::package", "Installs cookbooks.python using packages."
recipe "cookbooks.python::source", "Installs cookbooks.python from source."
recipe "cookbooks.python::pip", "Installs pip from source."
recipe "cookbooks.python::virtualenv", "Installs virtualenv using the python_pip resource."

%w{ debian ubuntu centos redhat fedora freebsd smartos }.each do |os|
  supports os
end
