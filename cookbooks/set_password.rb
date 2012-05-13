unless ARGV[0] && ARGV[1]
  puts "Usage: set_password.rb username password"
  exit 1
end

require 'chef'
require 'chef/config'
require 'chef/webui_user'

Chef::Config.from_file(File.expand_path("~/.chef/knife.rb"))

user = Chef::WebUIUser.load(ARGV[0])
if user
  user.set_password(ARGV[1])
  user.save
else
  puts "Could not find user #{ARGV[0]}."
  exit 2
end
