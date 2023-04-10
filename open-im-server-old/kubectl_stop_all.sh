#!/usr/bin/env bash

service=(
  #api service file
  api
  cms-api
  #rpc service file
  user
  friend
  group
  auth
  admin-cms
  office
  conversation
  cache
  msg-gateway
  msg-transfer
  msg
  push
)

for i in ${service[*]}
do
    kubectl -n openim delete deployment "${i}-deployment"
done
echo done