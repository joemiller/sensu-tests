# -*- mode: ruby -*-
# vi: set ft=ruby :

test_boxes = JSON.parse(File.read(File.join(File.dirname(__FILE__), 'boxes.json')),
                          :symbolize_names => true)

Vagrant::Config.run do |vagrant|
  test_boxes.each_pair do |name,box_attributes|
    vagrant.vm.define name do |config|
      config.vm.box = name.to_s
      config.vm.box_url = box_attributes[:box_url]
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
        chef.json = { 
          :sensu => { :ssl => box_attributes[:sensu_ssl] }
        }
      end

      # run our test suite
      config.vm.provision :shell, :inline => "gem install rake --no-rdoc --no-ri"
      config.vm.provision :shell, :inline => "cd /vagrant && rake spec"
    end
  end
end

