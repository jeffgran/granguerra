require 'whiskey_disk/rake'


namespace :deploy do

  task :fix_config do
    cmd = "cp #{Rails.root + '../granguerra_config/*'} #{Rails.root + 'config'}"
    puts "running `#{cmd}`"
    `#{cmd}`
  end

  task :restart_phusion do
    cmd = "touch #{Rails.root + 'tmp/restart.txt'}"
    puts "running `#{cmd}`"
    `#{cmd}`
  end

  task :post_deploy => ['assets:precompile', :restart_phusion]
end
