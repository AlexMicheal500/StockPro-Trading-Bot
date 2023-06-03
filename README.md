# StockPro-Trading-Bot-Documentation
## List of Documentations For Full Project:

i. How To Install StockPro Bot

ii. Deployment of StockPro WordPress Website

iii. Running a CI/CD Pipeline on StockPro WordPress Website. LINK TO GITLAB https://gitlab.com/alex_gitlab1/gassnownow-web-app

iv. Building StockPro WordPress Website 

## i. Video Link To How To Install StockPro Bot: https://vimeo.com/manage/videos/832894106/privacy
## Steps:
1. Visit tradingview.com through a browser or install a desktop version or or mobile version.
2. Click on "Get Started" to sign up for a tradingview account
![image](https://github.com/AlexMicheal500/StockPro-Trading-Bot/assets/99332618/9c82bb42-5b22-4aa7-ab34-db04671154a6)
3. Click on the assest on the left hand corner using and click on "Stocks":
![image](https://github.com/AlexMicheal500/StockPro-Trading-Bot/assets/99332618/3edbc1d0-1609-428d-a6a5-9ca356ff2326)
![image](https://github.com/AlexMicheal500/StockPro-Trading-Bot/assets/99332618/6449fb0e-525a-4e64-914b-866f758ae5a5)
4. Click on "All Countries" and Click on any country's Stock Exchange of choice.
![image](https://github.com/AlexMicheal500/StockPro-Trading-Bot/assets/99332618/6e4aa41e-78c8-48b3-af0b-600aea5edcb4)
![image](https://github.com/AlexMicheal500/StockPro-Trading-Bot/assets/99332618/24f9cfc5-b873-430d-a44c-00faeb579d46)
5. Then you will see displayed your chosen stock.
![image](https://github.com/AlexMicheal500/StockPro-Trading-Bot/assets/99332618/623d6196-cb2f-4f1c-889e-8ec7e1edfa43)
6. Copy the content of the stockpro_trading_bot_pinescript file and paste on a new script.
![image](https://github.com/AlexMicheal500/StockPro-Trading-Bot/assets/99332618/d79e67da-1560-4bb6-a140-69ba64053c27)
7. Paste content, input name of bot and publish
![image](https://github.com/AlexMicheal500/StockPro-Trading-Bot/assets/99332618/4d5f47cf-48a5-4f43-b101-db06ad1173b0)
![image](https://github.com/AlexMicheal500/StockPro-Trading-Bot/assets/99332618/29e380f5-4731-4756-b0af-b91beb0997f7)
8. Click "Add to Chart" and reduce the tab.
![image](https://github.com/AlexMicheal500/StockPro-Trading-Bot/assets/99332618/6145b784-31bc-4462-abd5-dba09ce7308b)
9. Then your bot is displayed on the chart.
![image](https://github.com/AlexMicheal500/StockPro-Trading-Bot/assets/99332618/9e1d7692-c8ec-41f6-bdf1-220285c19c5a)



## ii. DEPLOYMENT OF STOCKPRO WORDPRESS SITE
1. Installation of docker

   $ sudo apt install docker.io -y
   
2. Installation of docker-compose

   $ sudo apt install docker-compose -y
   
3. Clone repo of wp-content file, Docker-compose.yml and Dockerfile

   $ git clone https://github.com/AlexMicheal500/StockPro-Trading-Bot.git
   
4. Create image using Dockerfile

   $ docker built -t . <image_name>

5. Create container using :

   $ docker-compose -f docker-compose.yml up -d --build

6. Visit website on browser using:

   https://ip_address:8080
   
   
## iii. RUNNING A CI/CD PIPELINE ON STOCKPRO WORDPRESS SITE
BUILD STAGE 
Create a scripts folder on the gitlab repository
Create a build_script.sh file in the scripts folder
Input the following commands in build_script.sh
echo "SRS_HOST=$SRS_HOST" >> .env
echo "SRS_USER=$SRS_USER" >> .env
echo "SRS_PASSWORD=$SRS_PASSWORD" >> .env
echo "SRS_DB=$SRS_DB" >> .env
docker build -t $SOCIAL_REPUTATION_IMAGE .
docker save $SOCIAL_REPUTATION_IMAGE > social_reputation.tar
     Note: .env file should not be created on the repo.
Add the following commands to the .gitlab-ci.yml
    stage: build    
    image: docker:20.10.13-alpine3.15
    services:
       - docker:20.10.13-dind-alpine3.15
    script:
        - chmod u+x scripts/build_script.sh
- ./scripts/build_script.sh
Note: To test if .env file is created on the artifact, add the following to the script of the build stage on the .gitlab-ci.yml
if [ -f ".env" ]; then echo ".env exists in the artifact."; else echo ".env does not exist in the artifact."; fi

The result on the runner will be:

TESTING THE ARTIFACT
Download the artifact from gitlab.
Go to CICD menu and click “pipeline”
Click on “artifact” to download


Navigate to the file directory on the terminal.

Unzip the artifact:
unzip artifacts.zip.tar
Load the image from the artifact using:
docker load --input social_reputation.tar
To view the docker image:
docker images 
Clone the repo and create a docker container:
docker-compose -f docker-compose-prod.yml up -d --build 


PUSH STAGE 
Create a before_script.sh in the scripts directory.
Input the following commands in the before_script.sh
apk add --no-cache sshpass
which ssh-agent || ( apk update && apk add openssh-client )
mkdir -p ~/.ssh
touch ~/.ssh/id_rsa
echo "$SSH_PRIVATE_KEY" | tr -d '\r' > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
echo -e "Host *\nStrictHostKeyChecking no\n" > ~/.ssh/config
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
chmod 700 ~/.ssh
Create a docker_installation_script.sh in the scripts directory.
Input the following commands to install docker and docker-compose  in the docker_installation_script.sh
sudo apt-get update -y
sudo apt-get install docker.io -y
sudo docker -v
sudo systemctl enable --now docker
sudo apt  install docker-compose -y 
Add the following commands to the .gitlab-ci.yml

stage: push
    image: docker:20.10.13-alpine3.15
    before_script:
        - ls scripts/*	
        - chmod u+x scripts/before_script.sh
        - ./scripts/before_script.sh
    script:
        - chmod u+x scripts/push_script.sh
        - ./scripts/push_script.sh
 	       - sshpass -p $SERVER_PASSWORD ssh -tt -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "echo '$SERVER_PASSWORD' | sudo -S chmod u+x docker_installation_script.sh && echo '$SERVER_PASSWORD' | sudo -S ./docker_installation_script.sh"

DEPLOY STAGE 
Create a deploy_script.sh in the scripts directory.
Input the following commands in the deploy_script.sh
sudo docker load --input social_reputation.tar
sudo docker stop $SOCIAL_REPUTATION_CONTAINER && sudo docker rm $SOCIAL_REPUTATION_CONTAINER
sudo docker system prune -f
sudo docker volume prune -f
docker-compose -f docker-compose-prod.yml up -d --build
Add the following commands to the .gitlab-ci.yml
stage: deploy
    image: docker:20.10.13-alpine3.15
    before_script:
        - chmod u+x scripts/before_script.sh
        - ./scripts/before_script.sh
    script:      
        - sshpass -p $SERVER_PASSWORD ssh -tt -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "echo '$SERVER_PASSWORD' | sudo -S sh -c 'export SOCIAL_REPUTATION_IMAGE=$SOCIAL_REPUTATION_IMAGE && export SRS_HOST=$SRS_HOST && export SRS_USER=$SRS_USER && export SRS_DB=$SRS_DB && chmod u+x deploy_script.sh && ./deploy_script.sh'"


## iv. Building StockPro WordPress Website
1. Theme used is Astra

2. Plugin used is Elemntor Pro and Starter Template and Contact Form 7

3. Templates used are Tech Agency from Astra




