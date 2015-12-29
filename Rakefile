require "bundler/gem_tasks"
require 'rake/testtask'
require 'evertils/test'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

task :before do
  if ENV['TEST'].nil?
    Evertils::Test::Base.before
  end
end

task :after do
  if ENV['TEST'].nil?
    Evertils::Test::Base.after
  end
end

# hack from
# http://stackoverflow.com/questions/1689504/how-do-i-make-a-rake-task-run-after-all-other-tasks-i-e-a-rake-afterbuild-tas
current_tasks =  Rake.application.top_level_tasks
if current_tasks.include?('test')
  current_tasks << :after
  Rake.application.instance_variable_set(:@top_level_tasks, current_tasks)
  task :test => :before
end

desc "Run tests"
task :default => :test