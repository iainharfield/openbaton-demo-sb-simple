#!/bin/bash

token=$(curl -v -u openbatonOSClient:secret -X POST http://172.31.13.56:8080/oauth/token -H "Accept:application/json" -d "username=admin&password=openbaton&grant_type=password" | jq '.value')

token=$(sed -e 's/^"//' -e 's/"$//' <<<"$token")
#echo $token


project=$(curl -X GET -v -H "Content-type: application/json" -H "Authorization: Bearer $token"  -d '{}' "http://172.31.13.56:8080/api/v1/projects" | jq '.[0] .id')
project=$(sed -e 's/^"//' -e 's/"$//' <<<"$project")

#echo $project
nsd=$(curl -X GET -v -H "Content-type: application/json" -H "Authorization: Bearer $token" -H "project-id: $project"   -d '{}' "http://172.31.13.56:8080/api/v1/ns-descriptors" | jq '.')
nsd=$(sed -e 's/^"//' -e 's/"$//' <<<"$nsd")


#ns=$(curl -X POST -v -H "Content-type: application/json" -H "Authorization: Bearer $token" -H "project-id: $project"   -d '{}' "http://172.31.13.56:8080/api/v1/ns-records/17f52127-38fd-437a-a6b8-663eac355636" | jq '.')
#ns=$(sed -e 's/^"//' -e 's/"$//' <<<"$ns")

nsr=$(curl -X GET -v -H "Content-type: application/json" -H "Authorization: Bearer $token" -H "project-id: $project"   -d '{}' "http://172.31.13.56:8080/api/v1/ns-records" | jq '.')
nsr=$(sed -e 's/^"//' -e 's/"$//' <<<"$nsr")

#echo $nsr

#printf "\033c"
clear

echo $token
echo $project
echo $nsd
#echo $nsr
