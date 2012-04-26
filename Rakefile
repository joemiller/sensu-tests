require 'rake'

## -- tasks intended to be run outside of the VM's ---

desc "run librarian-chef to pull down all cookbooks"
task :chef_prep do
  ## install librarian manually instead of with bundler due to this:
  ##  https://github.com/applicationsonline/librarian/issues/35
  unless Gem.available? 'librarian'
    sh "gem install librarian --no-rdoc --no-ri --quiet"
  end
  sh "cd chef && librarian-chef update"
end

desc "execute vagrant to build all machines and run tests"
task :vagrant => [:bundler_install, :chef_prep] do
  sh "./para-vagrant.sh"
end

## -- tasks intended to be run inside of the VM's ---

desc "install bundler and other gems"
task :bundler_install do
  unless Gem.available? 'bundler'
    sh "gem install bundler --no-rdoc --no-ri --quiet"
  end
  sh "bundle install --quiet"
end

desc "run rspec tests"
task :spec => [:bundler_install] do
  # we are shelling out to rspec on purpose to avoid some bundler issues
  # that can happen with the ruby in /opt/sensu. Use RSpec::RakeTasks at your
  # own peril (or submit a patch if you make it work)
  sh "rspec -fd spec/spec_*.rb"
end

## --- general tasks, can be run inside or outside the VM's ----
task :usage do
  puts "There is no default task since this single Rakefile is meant to"
  puts "be run in two different contexts: "
  puts "   1) outside a VM to call vagrant and spin up boxes"
  puts "   2) inside a VM to run the test suite"
end

task :default => :usage
