#!/bin/bash

file1=/etc/ansible/pb/net.txt
file2=/etc/ansible/pb/c1.txt
file3=/etc/ansible/pb/c2.txt
net1=$(cat "$file1")
cont1=$(cat "$file2")
cont2=$(cat "$file3")
cont3='br'

cont4="${cont1}${cont3}"
cont5="${cont2}${cont3}"
#creating the bridges 
sudo brctl addbr $cont4
ip link set $cont4 up

sudo brctl addbr $cont5
ip link set $cont5 up

sudo brctl addbr br1
ip link set br1 up

#important
#modify the extra vars in any one of the following such as the ip addresses as per the network given in the csv file 

if [ "$net1" = "L3" ]
then
        sudo ansible-playbook l3_containers.yaml  --extra-vars "container1_name=$cont1 container2_name=$cont2 leafc1_ip='101.0.0.1/24' leafc2_ip='102.0.0.1/24' c1_ip='120.0.0.1/24' c2_ip='150.0.0.1/24' c1_netw='120.0.0.0/24' c2_netw='150.0.0.0/24'"
fi

if [ "$net1" = "L2" ]
then
        sudo ansible-playbook bridge_containers.yaml --extra-vars "container1_name=$cont1 container2_name=$cont2 leafc1_ip='101.0.0.1/24' leafc2_ip='102.0.0.1/24' c1_ip='120.0.0.1/24' c2_ip='150.0.0.1/24' c1_netw='120.0.0.0/24' c2_netw='150.0.0.0/24' lc1_mgmt_ip='172.17.0.4' lc2_mgmt_ip='172.17.0.8 ' lc1_ns_mgmt_ip='172.17.0.5' lc2_ns_mgmt_ip='172.17.0.6'"
fi
if [ "$net1" = "VXLAN" ]
then
        sudo ansible-playbook vxlan_containers.yaml  --extra-vars "container1_name=$cont1 container2_name=$cont2 leafc1_ip='101.0.0.1/24' leafc2_ip='102.0.0.1/24' c1_ip='120.0.0.1/24' c2_ip='150.0.0.1/24' c1_netw='120.0.0.0/24' c2_netw='150.0.0.0/24' lc1_mgmt_ip='172.17.0.4' lc2_mgmt_ip='172.17.0.8 ' lc1_ns_mgmt_ip='172.17.0.5' lc2_ns_mgmt_ip='172.17.0.6'"
fi
if [ "$net1" = "GRE" ]
then
        sudo ansible-playbook gre_containers.yaml  --extra-vars "container1_name=$cont1 container2_name=$cont2 leafc1_ip='101.0.0.1/24' leafc2_ip='102.0.0.1/24' c1_ip='120.0.0.1/24' c2_ip='150.0.0.1/24' c1_netw='120.0.0.0/24' c2_netw='150.0.0.0/24'"
fi

