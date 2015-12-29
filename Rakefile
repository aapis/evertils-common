require "bundler/gem_tasks"
require 'rake/testtask'
require 'evertils/test'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

task :before do
  Evertils::Test::Base.before
end

task :after do
  Evertils::Test::Base.after
end

# hack from
# http://stackoverflow.com/questions/1689504/how-do-i-make-a-rake-task-run-after-all-other-tasks-i-e-a-rake-afterbuild-tas
current_tasks =  Rake.application.top_level_tasks
current_tasks << :after
Rake.application.instance_variable_set(:@top_level_tasks, current_tasks)

desc "Run tests"
task :test => :before