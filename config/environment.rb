require 'bundler'
Bundler.require

# set the pathname for the root of the app
# ruby standard library
# ruby object 'Pathname'
require 'pathname'
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

# require the controller(s)
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }

# require the model(s)
Dir[APP_ROOT.join('app', 'models', '*.rb')].each { |file| require file }

# configure TaskManagerApp settings
class TaskManagerApp < Sinatra::Base
  set :method_override, true
  set :root, APP_ROOT.to_path
  set :views, File.join(TaskManagerApp.root, "app", "views")
  set :public_folder, File.join(TaskManagerApp.root, "app", "public")

  configure :test do
    set :database, File.join(TaskManagerApp.root, "db", "task_manager_test.sqlite3")
    set :environment, :test
  end

  configure :development do
    set :database, File.join(TaskManagerApp.root, "db", "task_manager_dev.sqlite3")
    set :environment, :development
  end
  
end
