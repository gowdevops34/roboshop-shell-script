source components/common.sh

CHECK_ROOT

PRINT "Setting Up Nodejs YUM Repo is "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash &>>${LOG}
CHECK_STAT $?

PRINT "Installing Nodejs"
yum install nodejs -y &>>${LOG}
CHECK_STAT $?

PRINT "Creating Application User"
id roboshop &>>${LOG}
if [ $1 -ne 0 ]; then
  useradd roboshop &>>${LOG}
fi
CHECK_STAT $?

PRINT "Downloading CArt Content"
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>${LOG}
CHECK_STAT $?

cd /home/roboshop

PRINT "Remove old Content"
rm -rf cart &>>${LOG}
CHECK_STAT $?

PRINT "Extract Cart Content"
unzip /tmp/cart.zip &>>${LOG}
CHECK_STAT $?

mv cart-main cart
cd cart

PRINT "Install Nodejs Dependencies for Cart Component"
npm install &>>${LOG}
CHECK_STAT $?

PRINT "Update SystemD Configuration"
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' /home/roboshop/cart/systemd.service &>>${LOG}
CHECK_STAT $?

PRINT "setup systemD Configuration"
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>${LOG}
CHECK_STAT $?

systemctl daemon-reload
systemctl enable cart

PRINT "Start Cart Service"
systemctl restart cart &>>${LOG}
CHECK_STAT $?


