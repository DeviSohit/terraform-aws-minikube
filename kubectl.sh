# copy this url by raw code and curl <url> | sudo bash. then kubectl will install inside workstation
#!/bin/bash
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"
USERID=$(id -u)

LOGSDIR=/tmp
# /home/centos/shellscript-logs/script-name-date.log
SCRIPT_NAME=$(basename "$0")
LOGFILE=$LOGSDIR/$SCRIPT_NAME-$DATE.log

echo -e "$Y This script runs on CentOS 8 $N"

if [[ "$USERID" -ne 0 ]];
then
    echo -e "$R ERROR:: Please run this script with root access $N"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ];
    then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" &>>$LOGFILE

VALIDATE $? "Download latest version of kubectl"

install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl &>>$LOGFILE

VALIDATE $? "kubectl installed"

kubectl version --client &>>$LOGFILE

VALIDATE $? "kubectl version"



