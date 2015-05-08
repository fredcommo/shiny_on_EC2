##### Create a EC2 Ubuntu instance: aws.amazon.com/
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
In the EC2 Instances page Description, click on the 'Security Groups', then:
- Select the 'Inboud' tab
- Add the following rules:
	- Type: HTTP, Protocole: TCP, Port range: 80, Source: anywhere 0.0.0.0/0
	- Type: Custom TCP rule, Protocole: TCP, Port range: 3838, Source: anywhere 0.0.0.0/0


#### Change the .pem mode first
chmod 400 \<my-key-pair.pem\>

#### Push the installShiny.sh file
cd /myKeyFolder
scp -i \<my-key-pair.pem\> path/to/local/installShiny.sh ubuntu@\<Public_IP\>:~

#### Connect to your EC2 instance
ssh -i \<my-key-pair.pem\> ubuntu@\<Public_IP\>

#### Change the file mode, then run
chmod +x installShiny.sh
./installShiny.sh

#### Starting the server should return something like: shiny-server start/running, process <some process number>
sudo start shiny-server

#### Back to your local machine, push your shiny app: AppFolder contains the ui.R and server.r (and any extra folder or file)
scp -i \<my-key-pair.pem\> -r \<path/to/local/AppFolder\> ubuntu@\<Public_IP\>:/srv/shiny-server

#### Run the app in a browser
http://\<Public_IP\>:3838/myApp

#### [An example with a very basic App](http://52.17.91.68:3838/basics/)