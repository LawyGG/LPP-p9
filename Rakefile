$:.unshift File.dirname(__FILE__) + 'lib'
$:.unshift './lib', './spec'

require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new
task :default => :spec

desc "Ejecutar las espectativas"
task :test do
  sh "rspec -I spec/matrix_rspec.rb"
end


desc "Ejecutar con documentacion"
task :doc do
   sh "rspec -I spec/matrix_rspec.rb --format documentation"
end

desc "Ejecutar con HTML"
task :html do
   sh "rspec -I spec/matrix_rspec.rb --format html > test.html"
end
