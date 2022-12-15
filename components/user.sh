curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop

curl -s -L -o /tmp/user.zip "https://github.com/roboshop-devops-project/user/archive/main.zip"
cd /home/roboshop
rm -rf user
unzip /tmp/user.zip
mv user-main user
cd /home/roboshop/user
npm install
#1. Update SystemD service file,

#   Update `REDIS_ENDPOINT` with Redis Server IP

#   Update `MONGO_ENDPOINT` with MongoDB Server IP

mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service
systemctl daemon-reload
systemctl start user
systemctl enable user