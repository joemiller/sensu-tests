sensu integration tests
=======================

The purpose of this test suite was originally to test the Sensu packages
(.rpm, .deb, etc) but it is also fairly useful for testing Sensu provisioning
systems such as sensu-chef.

Since the tests are run across 12 different platforms (as of April 2012) it's
also quite helpful at flushing out platform issues that may come up when using
Sensu on different OS's that may not be immediately obvious, e.g: Erlang
SSL issues on Ubuntu <= 11.04.

The test suite relies heavily on Vagrant. The boxes used for testing are
generally default/vanilla boxes built from Veewee templates. The boxes are
all available at:  http://vagrant.sensuapp.org

Dependencies
------------

- A physical box with a lot of mem. 16GB works, 8GB might.
- Oracle VirtualBox
- Vagrant (only tested with Vagrant 1.x)
- rake (should work on 0.8.7+ and 0.9.x)
- bundler
- GNU parallel(1)

Bundler will install everything else that's needed. The `rake bundler_install`
task will install bundler and run `bundle --install`.

Librarian-chef is used to pull down cookbooks. This should be done automatically
by the higher level rake tasks, but it can be run directly with `rake chef_prep`
too.

Note on Machine Resources
-------------------------

If you run the full test suite (`rake vagrant` or `para-vagrant.sh`) all
12 of the test VM's will be booted, but the provisioning tasks will only be
run on `NUM_CPUs` of VM's at a time. To change the testing concurrency, modify
`MAX_PROCS` in `para-vagrant.sh`.

Usage
-----

### Summary

The testing process is 2 steps:

1. install a full sensu-stack using Chef and the `sensu-chef` cookbooks.
2. run the rspec tests in `spec/spec_*`

### Running tests

There are multiple ways to use the test suite.

Note that there is no default rake task. The Rakefile contains a mix of tasks,
some which are only meant to be run outside of a VM, and some tasks that
should only be run inside a VM.

### Run tests on all platforms (para-vagrant.sh)

```
$ rake vagrant
```

Which does the following:

1. run `rake bundler_install` to install bundler and gems needed by Gemfile.
2. run `rake chef_prep` to download cookbooks in `chef/` using librarian.
3. run `./para-vagrant.sh` to kick off vagrant provisioning.

The `para-vagrant.sh` script first boots all the VM's sequentially to avoid
any VirtualBox kernel panics.

After the VM's are booted up, the `vagrant provision` (test) process will
be executed in parallel on the VM's to speed up testing.

The provisioning concurrency can be controlled by setting `$MAX_PROCS` at
the top of the script.

Detailed Logs of each provision process will be generated in the `logs/` 
directory.

### Run tests on a single platform

To run Chef + Rspec on just one platform, you can do:

1. `vagrant up <BOX_NAME>` - will boot the box and run the provision tasks.
2. `vagrant up --no-provision <BOX_NAME>` - Boot box but don't run provision.
3. `vagrant provision <BOX_NAME>` - Run provision tasks on one box. Good for 
   re-running a failed test.

The tests can also be run directly on a system with `rake rspec`.

Author
------

* [Joe Miller](https://twitter.com/miller_joe) - http://joemiller.me / https://github.com/joemiller

License
-------

    Author:: Joe Miller (<joeym@joeym.net>)
    Copyright:: Copyright (c) 2012 Joe Miller
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
