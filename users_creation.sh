#!/bin/bash

#create a new user
read -p "enter username:" username


sudo useradd -m $username
#set passwd
echo "Enter passwd"
sudo passwd $username
echo "Enter username:"

