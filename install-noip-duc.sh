LOGIN="test@example.com"
PASSWORD=MyPassword
INTERFACE=wlan0
INTERVAL=30

mkdir -p "$HOME/src/noip"
cd "$HOME/src/noip"
wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
tar zxf noip-duc-linux.tar.gz
cd noip-2.1.9-1
make clean
make
sudo cp noip2 /usr/local/bin/noip2

sudo chmod 700 /usr/local/bin/noip2
sudo chown root:root /usr/local/bin/noip2

# Run on boot

sudo cp debian.noip2.sh /etc/init.d/noip2
sudo chmod +x /etc/init.d/noip2
sudo update-rc.d noip2 defaults

# Config no-ip

killall noip2
sudo rm /usr/local/etc/no-ip2.conf
sudo noip2 -C -u$LOGIN -p$PASSWORD -I$INTERFACE -U$INTERVAL
