log_file = File.join(Rails.root, 'log', 'app.log')
system("touch #{log_file}") unless File.exist? log_file
App_LOG = Logger.new(log_file)
