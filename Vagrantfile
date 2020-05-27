VAGRANTFILE_API_VERSION = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Find boxes at https://atlas.hashicorp.com/search.
  config.vm.box = 'TODO'

  # OS X expects tty to be present when `sudo` is run
  # config.ssh.pty = true

  # Configure SSH (used during provisioning)
  # config.ssh.username = "developer"
  # config.ssh.password = "basebuild"
  # config.ssh.port = 22
  # config.ssh.forward_agent = true

  # Forwarded ports
  config.vm.network :forwarded_port, guest: 22, host: 27022, id: "ssh", auto_correct: true
  config.vm.network :forwarded_port, guest: 80, host: 27080, id: 'http', auto_correct: true
  config.vm.network :forwarded_port, guest: 443, host: 27443, id: 'https',  auto_correct: true

  # Network setup
  config.vm.network :private_network, ip: '••192.168.127.10••'
  config.vm.network :public_network

  # Shared folders
  # config.vm.synced_folder 'local_folder', '/mnt/hgfs/remote_folder'
  # config.vm.synced_folder 'local_folder', '/mnt/hgfs/remote_folder',
  #   type: 'rsync',
  #   rsync__args: ['--verbose', '--archive', '--compress', '--cvs-exclude'],
  #   rsync__exclude: ['.svn/', '.git/']

  # BindFS folders
  # if Vagrant.has_plugin?('vagrant-bindfs')
  #   config.vm.synced_folder "./pgdata", "/mnt/nfs/pgdata", type: "nfs", create: true
  #   config.bindfs.bind_folder "/mnt/nfs/pgdata/9.5", "/var/lib/pgsql/9.5/data", owner: "postgres", group: "postgres", perms: "g=:o="
  # end

  # Provider-specific: VirtualBox
  config.vm.provider :virtualbox do |vb|
    vb.name = 'TODO'
    vb.gui = false
    vb.cpus = 1
    vb.memory = '1024'

    # Use VirtualBox native disks
    # if ARGV[0] == "up" && ! File.exist?(HOME_DISK)
    #   vb.customize ['createhd',
    #                 '--filename', HOME_DISK,
    #                 '--format', 'VDI',
    #                 '--size', 50000]
    #
    #   vb.customize ['storageattach', :id,
    #                 '--storagectl', 'SATA Controller',
    #                 '--port', 0,
    #                 '--device', 0,
    #                 '--type', 'hdd',
    #                 '--medium', HOME_DISK]
    # end
  end

  # Configure VirtualBox Guest CD plugin
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = true
  end

  # Enable provisioning
  config.vm.provision 'shell', inline: <<-SHELL
    apt-get update
    apt-get install -y apache2
  SHELL
end
