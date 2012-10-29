#
# Cookbook Name:: apitrary_rails
# Recipe:: paymill_plans_synch
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

rails_env = node.chef_environment == "DEV" ? "staging" : "production"
cron "ga_stats_fetch" do
  hour "6,18"
  minute "15"
  command "cd /home/rails/launchpad/current && RAILS_ENV=#{rails_env} rake stats:fetch"
end