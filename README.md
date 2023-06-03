# StockPro-Trading-Bot-Documentation
## Video Link To How To Install Bot: https://vimeo.com/manage/videos/832894106/privacy
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



DEPLOYMENT OF WORDPRESS SITE
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
   
   







