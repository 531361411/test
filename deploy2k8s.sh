#!/bin/bash
# -- 部署image到k8s --
# !注意：需要提前做ssh免密登录
set -eu

#定义常量
PROJECT_NAME="cicd-demo"
UPLOAD_DIR="/home/root/apps/${PROJECT_NAME}"
FILE_NAME="${UPLOAD_DIR}/deploy.yaml"
SSH_USER="root"
SSH_IP="172.28.236.82"
echo 'start---'
#首先删除待上传目录的同名文件
ssh-keygen -R ${SSH_USER}@${SSH_IP} "rm -rf ${FILE_NAME}"
echo 'second---'
#确保部署文件目录存在
ssh-keygen -R ${SSH_USER}@${SSH_IP} "mkdir -p ${UPLOAD_DIR}"
echo 'last---'
#远程复制部署文件
scp -r deploy.yaml ${SSH_USER}@${SSH_IP}:${FILE_NAME}
echo 'end---'
#远程执行部署命令
ssh-keygen -R ${SSH_USER}@${SSH_IP} "kubectl apply -f ${FILE_NAME}"