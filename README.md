#### Create a EC2 Ubuntu instance: aws.amazon.com/
I don't want to go through this process. Amazon has a nice tutorial, very easy to follow.

Note:
ubuntu-trusty-14.04-amd64-server-20150325 (ami-47a23a30) works fine, and a t2-micro is enough for testing this.

#### Opening the right ports
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


#### On your local machine, change the .pem mode first
cd /myKeyFolder  
chmod 400 \<my-key-pair.pem\>

#### Push the installShiny.sh file to your remote EC2 instance
_Note: you will find the \<Public_IP\> in the Instance Desription page._

scp -i \<my-key-pair.pem\> path/to/local/installShiny.sh ubuntu@\<Public_IP\>:~  

#### Connect to your remote EC2 instance
ssh -i \<my-key-pair.pem\> ubuntu@\<Public_IP\>

#### Change the file mode, then run installShiny.sh
chmod +x installShiny.sh  
./installShiny.sh

#### Start the shiny server on the remote machine
sudo start shiny-server  

_Note: Starting the server should return something like: shiny-server start/running, process \<some process number\>_

#### Back to your local machine, push your shiny app folder, containing the ui.R and server.r (and any extra folder or file)
scp -i \<my-key-pair.pem\> -r \<path/to/local/AppFolder\> ubuntu@\<Public_IP\>:/srv/shiny-server

_Note: all your shinyApp folders should live in the /srv/shiny-server/ directory_

#### Run the app in a browser
http://\<Public_IP\>:3838/myApp

#### A very trivial example running on [EC2](http://52.17.91.68:3838/basics/)
_At least, until I kill that instance :p_
