# NodeJS Box
Vagrant Box for NodeJS Application

## Install Dependencies
- You will need Vagrant `2.0.0` and VirtualBox `5.1.26` or above
- Install vagrant-salt plugin `0.4.0` or above for using Salt Stack provisioning tool 
  ```
  vagrant plugin install vagrant-salt
  ```

## Project Setup
1. Download `nodejs_box-master.zip` file to your project directory and unzip
  ```
  $ cd <project>
  $ unzip nodejs_box.zip
  $ cd nodejs_box 
  ```

2. Use vagrant to create and provision the NodeJS virtual machine in Virtual Box
   ```
   $ vagrant up --provider virtualbox
   ```

3. You may run into provisioning failures due various reason. For now, simply provision again to continue
   ```
   $ vagrant provision
   ```
   Refer to **Known Issues** for more information

4. Login to your vagrant box using `vagrant ssh` command


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

    
### Design Condieration
1. Application destination port can be configured by editing salt pillar in `salt/pillar/nodejs/init.sls` 
2. Testing
3. Monitoring