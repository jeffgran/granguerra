namespace :deploy do
  task :restart_phusion do
    cmd = "touch #{Rails.root + 'tmp/restart.txt'}"
    puts "running `#{cmd}`"
    `#{cmd}`
  end

  task :post_deploy => [:restart_phusion]
end
