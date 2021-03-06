####1- Create an EC2 Ubuntu [instance](https://aws.amazon.com/)
I don't want to go through this process. Amazon has a nice [tutorial](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html), pretty easy to follow.

_Note: ubuntu-trusty-14.04-amd64-server-20150325 (ami-47a23a30) works fine, and a t2-micro is enough for testing small apps._

####2- Open the right ports
By default, the shiny server uses the port 3838. You need to have that port opened on your instance to be able
to open an app in a browser.

When starting a new instance, the 'review and launch' step allows you to edit the Security Groups.
Add the following new rules:
- Type: HTTP, Protocole: TCP, Port range: 80, Source: anywhere 0.0.0.0/0
- Type: Custom TCP rule, Protocole: TCP, Port range: 3838, Source: anywhere 0.0.0.0/0

If you missed this step, no worry!  
You can modify the 'Security Groups' rules through the EC2 Instance page Description.  
Click on the 'Security Groups', down your Instance Description window, then:
- Select the 'Inboud' tab
- Add the following rules:
	- Type: HTTP, Protocole: TCP, Port range: 80, Source: anywhere 0.0.0.0/0
	- Type: Custom TCP rule, Protocole: TCP, Port range: 3838, Source: anywhere 0.0.0.0/0


####3- On your local machine, change the .pem mode first
$ cd /myKeyFolder  
$ chmod 400 \<my-key-pair.pem\>

####4- Push the installUbuntu.sh file to your remote EC2 instance
_Note: you will find the \<Public_IP\> in the Instance Desription page._  
$ scp -i \<my-key-pair.pem\> path/to/local/installUbuntu.sh ubuntu@\<Public_IP\>:~  

####5- Connect to your remote EC2 instance
$ ssh -i \<my-key-pair.pem\> ubuntu@\<Public_IP\>

####6- Change the file mode, then run installUbuntu.sh
_on your remote machine_  
$ chmod +x installUbuntu.sh  
$ ./installUbuntu.sh

_Note: to install supplementary R packages, uncomment line \#51 in installUbuntu.sh, then replace 'pkg1', 'pkg2' with the package names you may need._

####7- Start the shiny server on the remote machine
_on your remote machine_  
$ sudo start shiny-server  

_Note: Starting the server should return something like: shiny-server start/running, process \<some process number\>._

####8- Back to your local machine, push your shiny app folder (ui.R, server.R, and any extra folder or file) to your remote machine
$ scp -i \<my-key-pair.pem\> -r \<path/to/local/AppFolder\> ubuntu@\<Public_IP\>:/srv/shiny-server

_Note: all your shinyApp folders should live in the /srv/shiny-server/ directory._

####9- Run the app in a browser
http://\<Public_IP\>:3838/\<myApp\>

_Notes:_  
_Public\_IP: see step \#4._  
_'myApp': same name as 'AppFolder' used in step \#8._

#### A very trivial example running on [EC2](http://52.17.91.68:3838/basics/)
_Instance killed!_
