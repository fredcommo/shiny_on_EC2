##### Create a EC2 Ubuntu instance
##### ubuntu-trusty-14.04-amd64-server-20150325 (ami-47a23a30) works fine, and a t2-micro is enough for testing this.

In the EC2 Instances page Description.
- Click on the 'Security Groups'
- Select the 'Inboud' tab
- Check whether ports 80 and 3838 are opened. If not, add the following rules
	- Type: Custom TCP rule, Protocole: TCP, Port range: 80, Source: anywhere 0.0.0.0/0
	- Type: Custom TCP rule, Protocole: TCP, Port range: 3838, Source: anywhere 0.0.0.0/0


### Change the .pem mode first
chmod 400 \<my-key-pair.pem\>

### Push the installShiny.sh file
cd /myKeyFolder
scp -i \<my-key-pair.pem\> path/to/local/installShiny.sh ubuntu@\<Public_IP\>:~

### Connect to your EC2 instance
ssh -i \<my-key-pair.pem\> ubuntu@\<Public_IP\>

### Change mode, then run
chmod +x installShiny.sh
./installShiny.sh

### Starting the server should return something like: shiny-server start/running, process <some process number>
sudo start shiny-server

### Back to your local machine, push your shiny app: AppFolder contains the ui.R and server.r (and any extra folder or file)
scp -i \<my-key-pair.pem\> -r \<path/to/local/AppFolder\> ubuntu@\<Public_IP\>:/srv/shiny-server

### Run the app in a browser
http://\<Public_IP\>:3838/myApp

### [An example with a very basic App](http://52.17.91.68:3838/basics/)