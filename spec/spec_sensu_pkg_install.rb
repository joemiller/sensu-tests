require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'spec_helper'))


describe "sensu package installation" do

  it "should have created a 'sensu' user and group" do
    user   = Etc.getpwnam('sensu')
    group  = Etc.getgrnam('sensu')
    user.gid.should == group.gid
  end

  %w[/etc/sensu /var/log/sensu].each do |file|
    it "#{file} should be owned by the 'sensu' user and group" do
      file_owner(file).should == 'sensu'
      file_group(file).should == 'sensu'
    end
  end

end
