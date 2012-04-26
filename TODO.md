key:
```
- open item
x closed item
```

TODO
----
x	move the `test_boxes` hash out of the vagrantfile into a json or yaml
    doc so that other tools can use it more easily.
x	`para-vagrant.sh` should read list of boxes (from json file, see above)
    instead of relying on hard-coded list of boxes in the script.

- CentOS 5/6: [rabbitmq]. is pulling down 2.6.1. Could update to pull 2.8.1

Bugs/Errors in Chef
-------------------

x [redis]. redis.conf.erb contains some settings that are too new for, eg:
  redis 2.0.x on some older ubunutus like 1104, 1004, etc
x CentOS 5/6: [redis]. added 'yum' cookbook as a dependency.
x CentOS 5/6: [redis]. include_recipe 'yum::epel' if platform is redhat. needed
  to get the redis rpm.
x CentOS 5/6: [redis]. if platform is redhat, package name should be 'redis'.
            
x centos *: [sensu]. yum repo path was incorrect. fixed.
x centos_5_32/64: [sensu]. package options '--force-yes' were specific to deb 
  and causing yum to bomb. fixed by adding platform specific 'package_options' 
  variable.

x debian/ubuntu: [sensu]. apt-get will fail if a config file is newer in
  the sensu .deb when updating to a new .deb. fix: add to the new 
  `package_options` var, following this guide: http://askubuntu.com/questions/104899/make-apt-get-or-aptitude-run-with-y-but-not-prompt-for-replacement-of-configu

x debian-6: [sensu]. Install redis from source instead of package. otherwise
  we get old redis 1.2.x

### test suite failures

x ubuntu_1004_64
x ubuntu_1104_32  (redis 2.0.x config issues)
x ubuntu_1104_64  (redis 2.0.x config issues)
x debian_6_32	(redis 1.0.x distro package gets installed.)
x debian_6_64	(redis 1.0.x distro package gets installed.)
