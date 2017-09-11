# NodeJS Box
Vagrant Box for NodeJS Application

## Installing Vagrant & Virtual Box 
- Download & install [Vagrant](https://www.vagrantup.com/downloads.html) `2.0.0` and [VirtualBox](https://www.virtualbox.org/wiki/Downloads) `5.0.0` or above
- Install vagrant-salt plugin `0.4.0`. This is for Salt Stack provisioning tool 
  ```
  vagrant plugin install vagrant-salt
  ```
  
## Supported OS
- Mac OS Sierra
- Ubuntu Trusy64

## Project Setup
1. Download `nodejs_box-master.zip` file to your project directory and unzip
  ```
  $ cd <project>
  $ unzip nodejs_box-master.zip
  $ cd nodejs_box-master
  ```

2. Use vagrant to create and provision the NodeJS virtual machine in Virtual Box
   ```
   $ vagrant up --provider virtualbox
   ```

3. You may run into provisioning failures when initially bring up the box. As a workaround, use this command again to provision
   ```
   $ vagrant provision
   ```
   Refer to **Known Issues** for more information

4. Next, login to vagrant box using `vagrant ssh` command to validate the box

5. Test application is up
   ```
   $ sudo systemctl status app | grep 'active'
   Active: active (running) since Mon 2017-09-11 07:55:12 UTC; 1min 42s ago
   
   $ curl http://localhost:8080
   Hello World
   ```

6. Ensure the rest of the processes are running
   ```
   $ sudo service memcached status
   * memcached is running

   $ sudo service nginx status
   * nginx is running
   
   $ sudo /etc/init.d/mysql status
   mysql start/running, process 11279
   ```

7. Congratulations! You are now ready to develop you application. Application code can be found in application folder of this project. Simply use the `sudo systemctl restart app` to apply changes to your application.
   ```
   $ tree application/
   application/
   ├── README.md
   └── src
      └── app.js
   ```

8. You can also change application attributes by modfiying [Salt Pillars](https://docs.saltstack.com/en/latest/topics/pillar/) in `salt/pillar/nodejs/init.sls` file.
   ```
   nodejs:
    major_version: 6
    version: 6.11.3-1nodesource1
    repository_url: "https://deb.nodesource.com/node_6.x"
    package:
      path: "/usr/bin"
    application:
      name: "app"
      path: "/opt/app/src"
      port: 8080
    firewall:
      ip: "10.0.0.0"
      subnet_mask: "8" 
    deps:
      memcached:
        version:  1.4.14-0ubuntu9.1
      # For mysql, refer to pillar/mysql/init.sls file
   ```
   Then run the `vagrant provision` command to apply changes to your box.

## Known Issues
#### The named service app is not available
- Symptoms: NodeJS app service takes time to register with system.d.
- Workaround: Run `vagrant provision` again

#### Module function service.systemctl_reload is not available
- Symptoms: NodeJS app service takes time to register with system.d.
- Workaround: Run `vagrant provision` again

#### Console output not colorized for salt provisioning
- Symptoms: `vagrant provision` does not show colorized output
- Workaround: Login to vagrant box and use the following command to provision
  ```
  sudo salt-call --local state.apply -l debug
  ```        

    
## Design Considerations
#### Provisioning Tool
Salt Stack was offers distinct advantage over other provisioning tools.
- Highly scalable due to it's multi-master architecture
- Reactor system gives Salt the ability to automatically trigger recovery action(s) in response to an event. Events from each minion can be sent to Salt Master or third party applications. 
- Salt command module provides an SSH-less interface to send command to targeted minions
- Salt cloud provides an easy interface to spin up resources in leading private and public cloude proviers (i.e. AWS, Google, VMWare etc.)

#### Validation
- *Versioning* of all the tools within the tools chain is one of the most important aspects of validation and testing. All tools must be versioned and tested on targeted OS. 
- All combinations of operating systems must be tested thourough
- In order to ensure repeatability of infrastructure, this repository must be setup with a Continuous Integration (CI) tool such as Team City or Jenkins. Each change set should trigger a build that spins up the application and performs the necessary validation. All changes off of feature branch must be reviewed and validated before they are checked into the main line. 

#### Monitoring
For this project, Salt Stack [Beacons](https://docs.saltstack.com/en/latest/topics/beacons/) will be sufficient for monitoring. Custom monitoring scripts can be developed to monitor several processes (app, mysql, memcached), CPU and disk usage. 

For staging and production environments, we can integrate with (Sensu)[https://sensuapp.org/] or other leading monitoring tool. We will also need to setup an Elastic Stack to gather and monitor logging. Eventually aggregate all the incidents and generate "actionable" alerts to Slack or Pager Duty for notification.

