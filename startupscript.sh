#!/bin/bash
# Simple shell script to install nginx and epel

sudo yum -y install epel-release
sudo yum -y install nginx 
sudo nginx -v

