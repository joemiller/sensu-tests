# -*- mode: ruby -*-
# vi: set ft=ruby :

test_boxes = {
  :centos_6_64    => 'http://vagrant.sensuapp.org/centos-6-x86_64.box',
  :centos_6_32    => 'http://vagrant.sensuapp.org/centos-6-i386.box',
  :ubuntu_1004_32 => 'http://vagrant.sensuapp.org/ubuntu-1004-i386.box',
  :ubuntu_1004_64 => 'http://vagrant.sensuapp.org/ubuntu-1004-amd64.box',
  :ubuntu_1104_32 => 'http://vagrant.sensuapp.org/ubuntu-1104-i386.box',
  :ubuntu_1104_64 => 'http://vagrant.sensuapp.org/ubuntu-1104-amd64.box',
  :ubuntu_1110_32 => 'http://vagrant.sensuapp.org/ubuntu-1110-i386.box',
  :ubuntu_1110_64 => 'http://vagrant.sensuapp.org/ubuntu-1110-amd64.box',
  :ubuntu_1204_32 => 'http://vagrant.sensuapp.org/ubuntu-1204-i386.box',
  :ubuntu_1204_64 => 'http://vagrant.sensuapp.org/ubuntu-1204-amd64.box',
  :debian_6_32    => 'http://vagrant.sensuapp.org/debian-6-i386.box',
  :debian_6_64    => 'http://vagrant.sensuapp.org/debian-6-amd64.box',
  :centos_5_64    => 'http://vagrant.sensuapp.org/centos-5-x86_64.box',
  :centos_5_32    => 'http://vagrant.sensuapp.org/centos-5-i386.box',
  # :debian_5_32    => '',
  # :debian_5_64    => ''
}

Vagrant::Config.run do |vagrant|
  test_boxes.each_pair do |name,url|
    vagrant.vm.define name do |config|
      config.vm.box = name.to_s
      config.vm.box_url = url
      # convert underscores in hostname to '-' so ubuntu 10.04's hostname(1)
      # doesn't freak out on us.
      hostname = "sensu-build-#{name.to_s.tr('_','-')}"
      config.vm.customize ['modifyvm', :id, '--memory', '640']
      # config.vm.customize ['modifyvm', :id, '--cpus', '2']

      # some of our boxes are missing some important pkgs that are needed very
      # early, such as to install/compile native gems. try to  install them here
      config.vm.provision :shell, :inline => "apt-get -y install make || true"

      # setup the sensu stack using chef
      config.vm.provision :shell, :inline => "gem install chef --no-rdoc --no-ri"
      config.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = "chef/cookbooks"
        chef.data_bags_path = "chef/data_bags"
        chef.roles_path = "chef/roles"
        chef.add_role("vagrant")
      end

      # run our test suite
      config.vm.provision :shell, :inline => "gem install rake --no-rdoc --no-ri"
      config.vm.provision :shell, :inline => "cd /vagrant && rake spec"
    end
  end
end

