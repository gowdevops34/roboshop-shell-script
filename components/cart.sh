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
