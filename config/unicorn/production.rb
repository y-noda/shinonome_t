rails_root = File.expand_path('../../../', __FILE__)

worker_processes 5

listen "#{rails_root}/tmp/sockets/unicorn.sock"
pid "#{rails_root}/tmp/pids/unicorn.pid"

stderr_path "#{rails_root}/log/unicorn.error.log"
stdout_path "#{rails_root}/log/unicorn.log"

working_directory rails_root

preload_app true

before_fork do |server, worker|
  ENV['BUNDLE_GEMFILE'] = File.expand_path('Gemfile', rails_root)
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
