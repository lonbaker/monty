require 'rubygems'
require 'rake'

require 'lib/monty.rb'
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "monty"
    gem.version = Monty.version
    gem.summary = %Q{Rack based authorization system}
    gem.description = %Q{Rack based authoriztion system.}
    gem.email = "andy@stonean.com"
    gem.homepage = "http://github.com/stonean/monty"
    gem.authors = ["stonean"]
    gem.add_development_dependency "mocha", ">= 0.9.8"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

begin
  require 'yard'
  YARD::Rake::YardocTask.new do |t|
    t.files   = FileList['lib/**/*.rb']
    t.options = ['-r'] # optional
  end
rescue LoadError
  task :yard do
    abort "YARD is not available. In order to run yard, you must: sudo gem install yard"
  end
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
    test.rcov_opts = IO.readlines("test/rcov.opts").map {|l| l.chomp.split " "}.flatten
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install rcov"
  end
end

task :default => :test
