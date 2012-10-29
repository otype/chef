#
# Cookbook Name:: apitrary_rails
# Recipe:: paymill_plans_synch
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

rails_env = node.chef_environment == "DEV" ? "staging" : "production"
cron "paymill_plans_synch" do
  hour "6,18"
  minute "0"
  command "cd /home/rails/launchpad/current && RAILS_ENV=#{rails_env} rake plans:synch"
end