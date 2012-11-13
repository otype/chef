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
  hour "*/6"
  minute "0"
  command "cd /home/rails/launchpad/current && RAILS_ENV=#{rails_env} /usr/local/bin/rake plans:synch  && echo `date` > /root/last_cron_run.paymill_plans_synch"
end