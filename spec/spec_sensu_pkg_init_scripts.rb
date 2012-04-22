require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'spec_helper'))

describe "sensu init scripts" do

  %w[sensu-api
    sensu-client
    sensu-dashboard
    sensu-server].each do |app|

    context "#{app}" do

      it "should start successfully and exit with exitstatus '0'" do
        result = start_service(app)
        result.exitstatus.should == 0
        sleep 1
        is_running?( %r[/opt/sensu/bin/#{app}] ).should == true
        result.exitstatus.should == 0
      end

      it "should stop successfuly" do
        stop_service(app)
        sleep 1
        is_running?( %r[/opt/sensu/bin/#{app}] ).should == false
      end

      it "should restart successfully" do
        restart_service(app)
        sleep 1
        is_running?( %r[/opt/sensu/bin/#{app}] ).should == true        
      end

      it "should be running as the 'sensu' user" do
        process = get_processes( %r[/opt/sensu/bin/#{app}] ).first
        process.uid.should == Etc.getpwnam('sensu').uid
      end

      it "should exit with status '0' if it's already running and 'start' is called" do
        if is_running?( %r[/opt/sensu/bin/#{app}] )
          result = start_service(app)
          result.exitstatus.should == 0
        end
      end

    end

  end

end
