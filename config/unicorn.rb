# worker_processes 2

# working_directory $APP_ROOT

# listen "/tmp/unicorn.rails_docker.sock"
# timeout 30

# pid "tmp/unicorn.rails_docker.pid"

# stderr_path "log/unicorn.log"
# stdout_path "log/unicorn.log"

############# for mina unicorn 自动部署  ###################
# app_path = File.expand_path( File.join(File.dirname(__FILE__), '..', '..'))
app_path = "/app_path/"

# Set unicorn options
worker_processes   2
preload_app        true
timeout            180

user               'user', 'user_group'

# Fill path to your app
working_directory  "#{app_path}/current"

# Set up socket location
listen             "#{app_path}/tmp/sockets/unicorn.sock", :backlog => 64

# Set master PID location
pid                "#{app_path}/tmp/pids/unicorn.pid"

# Loging
stderr_path        "log/unicorn.log"
stdout_path        "log/unicorn.log"

# local variable to guard against running a hook multiple times.
run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  if run_once
    run_once = false # prevent from firing again
  end
  # old_pid = "#{server.config[:pid]}.oldbin"
  # if File.exists?(old_pid) && server.pid != old_pid
  #   begin
  #     sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
  #     Process.kill(sig, File.read(old_pid).to_i)
  #   rescue Errno::ENOENT, Errno::ESRCH
  #     # someone else did our job for us
  #   end
  # end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_path}/current/Gemfile"
end
