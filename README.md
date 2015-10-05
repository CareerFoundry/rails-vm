# Introduction

Setting up Ruby on Rails on Windows machines is a common source of frustration among web developers. This is perhaps because the framework itself is open source in nature, and the fact that many web servers run on Linux. It is still possible to develop Rails apps successfully on Windows, but it takes a bit of extra work. Though there are several packages on the web which attempt to ease the pain of the installation process on Windows, the experience of our mentors and students has shown that the best approach is to set up a Linux virtual machine inside Windows, which handles the executing of the Rails app. There are two key pieces of free software which make this possible: VirtualBox, which is a virtual machine application, and Vagrant, which will automatically configure all the necessary software to run your Rails app.

This guide has been adapted from a [GoRails guide](https://gorails.com/guides/using-vagrant-for-rails-development) as well as instructions and configuration files contributed by CareerFoundry mentor Simon Bacquie.

## Setup

Make sure [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads.html) are installed before proceeding.

### Install necessary Vagrant plugins from your Windows prompt
    vagrant plugin install vagrant-vbguest
    vagrant plugin install vagrant-librarian-chef-nochef
    vagrant plugin install vagrant-multi-putty

### Change directory to your Rails project folder from Windows command line
This goes for wherever your project folder is:

    cd my_rails_project

### Copy files from this repo into your Rails project folder
    Vagrantfile
    Cheffile

These contain a pre-made configuration for the Virtual Machine we're about to build. They will direct Vagrant to install all the necessary software for developing your Rails app.

### Initialize Git repository
If you haven't done so already, initialize your project folder as a Git repository. You can go to Github.com, select "New Repo" from the "+" icon, and follow their instructions.

### Add config files to .gitignore in Rails project
Open up your .gitignore file in the root of your project folder and add these lines:

    .vagrant
    cookbooks/

Save the file and then commit. This step is very important. Without doing this, you'll likely end up with a huge (5 GB or so) Virtual Machine file checked into your Git repo, which GitHub will reject for being too large on your next push.

### From Git Bash in Rails project folder
    vagrant up

Wait while Ubuntu, Ruby, etc. are installed... you'll see a lot of text and this may take some time to run. These components only need to be installed the first time you run `vagrant up`.

    vagrant ssh

This connects to the VM and gives you a command prompt in the Linux environment. The prompt should look something like:

    vagrant@vagrant-ubuntu-trusty-64

From here, you can run any terminal commands necessary for the project, like `rails server`, `rails generate`, `rake`, etc.

### Go to your project folder from within the VM
    cd /vagrant
    ls

The /vagrant folder is created by default to point to your Rails project folder when you run `vagrant up`. The `ls` command should list your Rails project files.

### Start Rails server inside VM
    bundle
    rbenv rehash
    rails s -b 0.0.0.0

What we just did here:
  - `bundle` installs the gems in your Gemfile on the virtual machine, including Rails itself.
  - `rbenv rehash` will reload the ruby environment so certain executables can be found (the `rails` command etc.). If you try to run `rails s` before doing this, you will get an error, with a message to install rails from a package. You don't need to do this! Bundle should have already installed it. Just run the above commands in order.
  - `rails s` is the standard shorthand command to start the rails server. The `-b` flag will bind the rails server to the 0.0.0.0 IP address  within the virtual machine. This is necessary because by default the rails server binds to 127.0.0.1 (a.k.a. localhost), but that IP address is only accessible directly on the machine where the server is running. 0.0.0.0 is publicly accessible and will allow you to view the app from localhost:3000 in your browser on your host machine ("host machine" = your Windows machine).

Now, inside a browser in Windows, go to http://localhost:3000, and you should see a webpage served up from your Rails app!

# Working with Vagrant VMs

The suggested workflow with Vagrant and VMs is to develop on your Windows machine in your IDE of choice (Sublime Text, Atom, et al), and test the code on the virtual machine. You should keep a couple terminal windows open: one for running your Rails server inside the virtual machine, and another with the virtual machine SSH terminal open, in case you need to run any Rails commands while the server is running. Because you'll be editing the code in your Windows environment, you can commit and push to github, and push to heroku from there as well.

Virtual machines are essentially like another computer running inside your computer. As such, you have to start it up and shut it down like an actual computer. To reiterate the steps for development, start up your Vagrant VM using `cd` to get into your project folder (from a Windows prompt) and running:

    vagrant up

Once the VM is running, you can connect to it and get a command line with:

    vagrant ssh

Once you are logged into your VM terminal, navigate to your app folder with `cd /vagrant` and start the Rails server with `rails s -b 0.0.0.0` and open up http://localhost:3000 in a browser window.

When you are done working, you can stop the Rails server in the VM terminal window at any point by pressing `CTRL + C`. You can shut down the VM  from the Windows command line, in your project folder, with:

    vagrant halt

You'll want to shut down the VM when not working on development, as it consumes a lot of memory and will slow down your machine or use up battery life.
