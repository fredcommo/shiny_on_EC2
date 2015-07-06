#!/bin/bash

echo
echo Updating Ubuntu packages...
sleep 2
sudo apt-get update

echo
echo Installing libcurl...
sleep 2
sudo apt-get install -y libcurl4-openssl-dev
echo

echo Installing R...
sleep 2
sudo apt-get install -y r-base
sudo apt-get install -y r-base-dev
echo

echo Writting .Rprofile...
sleep 2
touch .Rprofile
echo "
local({
  r <- getOption('repos')
  r['CRAN'] <- 'http://cran.univ-lyon1.fr/'
  options(repos = r)
})

.libPaths('/usr/lib/R/library')

" > .Rprofile
echo

sudo chmod 777 /usr/lib/R/library

echo Installing shiny...
sleep 2
sudo su - -c "R -e \"install.packages('shiny', repos='http://cran.rstudio.com/', lib='/usr/lib/R/library/')\""
echo

echo Installing shiny server...
sudo apt-get install -y gdebi-core
wget http://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.3.0.403-amd64.deb
echo "y" | sudo gdebi shiny-server-1.3.0.403-amd64.deb
sudo rm shiny-server-1.3.0.403-amd64.deb
echo

echo Installing supplementary R packages...
sleep 2
#sudo su - -c "R -e \"install.packages(c('pkg1', 'pkg2', ...), repos='http://cran.univ-lyon1.fr/', lib='/usr/lib/R/library/')\""
echo

echo Changing chmod 777 /srv/shiny-server/ permissions...
sudo chmod 777 /srv/shiny-server/
echo Done.
echo

echo
echo Everything is installed !
echo

echo "*******************************************************************************"
echo "-------------------------------------------------------------------------------"
echo
echo You should be able to push your Apps folders to '/srv/shiny-server/'
echo e.g. 'scp -i <my_key_pair.pem> <path/to/myShyniApp> ubuntu@<Public_IP>:/srv/shiny-server'
echo
echo "-------------------------------------------------------------------------------"
echo "*******************************************************************************"
echo


