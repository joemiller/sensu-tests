require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'spec_helper'))


describe "sensu integration test #1" do

  before do
    handler_script = <<-EOF.gsub(/^\s+\|/, '')
      |#!/usr/bin/env ruby
      |require 'rubygems' if RUBY_VERSION < '1.9.0'
      |require 'json'
      |
      |event = STDIN.read
      |File.open("/tmp/integration_test1_handler_output.txt", 'w') do |f|
      |  f.write(event)
      |end
    EOF

    check_json = <<-EOF.gsub(/^\s+\|/, '')
      |{
      |  "checks": {
      |    "tester": {
      |      "handler": "integration_test1_handler",
      |      "command": "echo 'this is only a test'; exit 2",
      |      "interval": 30,
      |      "subscribers": [ "vagrant" ]
      |    }
      |  }  
      |}
    EOF

    handler_json = <<-EOF.gsub(/^\s+\|/, '')
      |{
      |  "handlers": {
      |    "integration_test1_handler": {
      |      "type": "pipe",
      |      "command": "/etc/sensu/handlers/integration_test1_handler"
      |    }
      |  }
      |}
    EOF

    File.open('/etc/sensu/handlers/integration_test1_handler', 'w') { |f| f.write handler_script }
    File.open('/etc/sensu/conf.d/integration_test1_check.json', 'w') { |f| f.write check_json }
    File.open('/etc/sensu/conf.d/integration_test1_handler.json', 'w') { |f| f.write handler_json }
    File.chmod(0755, '/etc/sensu/handlers/integration_test1_handler')

    File.delete('/tmp/integration_test1_handler_output.txt') rescue ''
    restart_service('sensu-client')
    restart_service('sensu-server')
  end

  it "should create file: /tmp/integration_test1_handler_output.txt" do
    max_wait = 60
    puts "Waiting up to #{max_wait} seconds for test to complete..."
    wait 60 do
      File.exists?('/tmp/integration_test1_handler_output.txt').should == true
    end
  end

end