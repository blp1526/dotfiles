# -*- mode: ruby -*-
# vi: set ft=ruby :

cpus     = ENV['VAGRANT_CPUS']
memory   = ENV['VAGRANT_MEMORY']
hostname = ENV['VAGRANT_HOSTNAME']
ip       = ENV['VAGRANT_IP']

Vagrant.configure("2") do |config|
  if Vagrant.has_plugin?('vagrant-vbguest')
    config.vbguest.auto_update = false
  end

  config.vm.define :dev do |node|
    node.vm.provider 'virtualbox' do |provider|
      provider.cpus = cpus
      provider.memory = memory
    end

    node.vm.box = 'ubuntu/focal64'
    node.vm.hostname = hostname
    node.vm.network :private_network, ip: ip
  end
end
