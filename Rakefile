require File.join(File.dirname(__FILE__), 'lib/spindle_gouge.rb')

unless ENV['RACK_ENV'] == 'production'
  require 'rspec/core/rake_task'
  require 'cucumber/rake/task'
  require 'coveralls/rake/task'
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'

  Cucumber::Rake::Task.new
  RSpec::Core::RakeTask.new
  Coveralls::RakeTask.new

  task :default => [:cucumber, :spec, 'jasmine:ci', 'coveralls:push']
end
