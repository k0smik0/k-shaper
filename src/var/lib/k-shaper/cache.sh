ifconfig imq0 up 

tc qdisc add dev imq0 root handle 1 htb default 200 
tc class add dev imq0  parent 1  classid 2 htb  rate 10mbit   burst 15k  

tc class add dev imq0  parent 2  classid 20 htb  rate 3mbit   burst 15k  

tc class add dev imq0  parent 20  classid 22 htb  rate 3mbit   burst 15k  
tc qdisc add dev imq0  parent 1:22 handle 22 sfq    
tc filter add dev imq0 protocol ip parent 1:0 prio 1 handle 22 fw classid 22
iptables -t mangle -A POSTROUTING -m layer7 --l7proto ssh -j MARK --set-mark 22

tc class add dev imq0  parent 20  classid 23 htb  rate 3mbit   burst 15k  
tc qdisc add dev imq0  parent 1:23 handle 23 sfq    
tc filter add dev imq0 protocol ip parent 1:0 prio 1 handle 23 fw classid 23
iptables -t mangle -A POSTROUTING --source 192.168.0.14 -j MARK --set-mark 23
iptables -t mangle -A POSTROUTING -m layer7 --l7proto telnet -j MARK --set-mark 23

tc class add dev imq0  parent 2  classid 10 htb  rate 10mbit   burst 15k  
tc qdisc add dev imq0  parent 1:10 handle 10 sfq    
tc filter add dev imq0 protocol ip parent 1:0 prio 1 handle 10 fw classid 10
iptables -t mangle -A POSTROUTING -p tcp --destination-port 80 -j MARK --set-mark 10

tc class add dev imq0  parent 2  classid 33 htb  rate 2mbit   burst 15k  
tc qdisc add dev imq0  parent 1:33 handle 33 sfq    
tc filter add dev imq0 protocol ip parent 1:0 prio 1 handle 33 fw classid 33
iptables -t mangle -A POSTROUTING -m owner --pid-owner 5600  -j MARK --set-mark 33

tc class add dev imq0  parent 2  classid 200 htb  rate 1mbit ceil 500Kbit  burst 15k  
tc qdisc add dev imq0  parent 1:200 handle 200 sfq    
tc filter add dev imq0 protocol ip parent 1:0 prio 1 handle 200 fw classid 200

iptables -t mangle -A PREROUTING -j IMQ --todev 0


ifconfig imq1 up 

tc qdisc add dev imq1 root handle 1 htb default 200 
tc class add dev imq1  parent 1  classid 2 htb  rate 10mbit   burst 15k  

tc class add dev imq1  parent 2  classid 20 htb  rate 3mbit   burst 15k  

tc class add dev imq1  parent 20  classid 22 htb  rate 3mbit   burst 15k  
tc qdisc add dev imq1  parent 1:22 handle 22 sfq    
tc filter add dev imq1 protocol ip parent 1:0 prio 1 handle 22 fw classid 22
iptables -t mangle -A POSTROUTING -m layer7 --l7proto ssh -j MARK --set-mark 22

tc class add dev imq1  parent 20  classid 23 htb  rate 3mbit   burst 15k  
tc qdisc add dev imq1  parent 1:23 handle 23 sfq    
tc filter add dev imq1 protocol ip parent 1:0 prio 1 handle 23 fw classid 23
iptables -t mangle -A POSTROUTING --source 192.168.0.14 -j MARK --set-mark 23
iptables -t mangle -A POSTROUTING -m layer7 --l7proto telnet -j MARK --set-mark 23

tc class add dev imq1  parent 2  classid 10 htb  rate 10mbit   burst 15k  
tc qdisc add dev imq1  parent 1:10 handle 10 sfq    
tc filter add dev imq1 protocol ip parent 1:0 prio 1 handle 10 fw classid 10
iptables -t mangle -A POSTROUTING -p tcp --destination-port 80 -j MARK --set-mark 10

tc class add dev imq1  parent 2  classid 33 htb  rate 2mbit   burst 15k  
tc qdisc add dev imq1  parent 1:33 handle 33 sfq    
tc filter add dev imq1 protocol ip parent 1:0 prio 1 handle 33 fw classid 33
iptables -t mangle -A POSTROUTING -m owner --pid-owner 5600  -j MARK --set-mark 33

tc class add dev imq1  parent 2  classid 200 htb  rate 1mbit ceil 500Kbit  burst 15k  
tc qdisc add dev imq1  parent 1:200 handle 200 sfq    
tc filter add dev imq1 protocol ip parent 1:0 prio 1 handle 200 fw classid 200

iptables -t mangle -A POSTROUTING -j IMQ --todev 1
