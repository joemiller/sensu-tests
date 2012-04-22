require 'rubygems'
require 'rspec'

# load any files matching name './**/*_helpers.rb'
Dir[File.expand_path(File.join(File.dirname(__FILE__), '**/*_helpers.rb'))].each do |helper|
  require helper
 end


RSpec.configure do |config|
  # config.filter_run_excluding :skip => true
  # config.filter_run_excluding :slow => true
end

