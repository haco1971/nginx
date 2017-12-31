# nginx
Installing Nginx and Nginx-RTMP
sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev

mkdir ~/working
cd ~/working
wget http://nginx.org/download/nginx-1.13.7.tar.gz
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
sudo apt-get install unzip
tar -zxvf nginx-1.13.7.tar.gz
unzip master.zip
cd nginx-1.13.7
./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master
make
sudo make install
sudo wget https://raw.github.com/JasonGiedymin/nginx-init-ubuntu/master/nginx -O /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx
sudo update-rc.d nginx defaults
sudo service nginx start
sudo service nginx stop
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:kirillshkrogalev/ffmpeg-next
sudo apt-get update
sudo apt-get install ffmpeg
sudo nano /usr/local/nginx/conf/nginx.conf

Append the following.
======================================================
rtmp {
    server {
            listen 1935;
            chunk_size 4096;

            application live {
                    live on;
                    record off;
                    allow publish 127.0.0.1;
                    allow publish 0.0.0.0;
                    deny publish all;
                    exec ffmpeg -i rtmp://localhost/live/$name -threads 1 -c:v libx264 -profile:v baseline -b:v 350K -s 640x360 -f flv -c:a aac -ac 1 -strict -2 -b:a 56k rtmp://localhost/live360p/$name;
            }
            application live360p {
                    live on;
                    record off;
                    allow publish 127.0.0.1;
                    allow publish 0.0.0.0;
                    deny publish all;
        }
    }
}
===================================================
sudo service nginx restart
Configuring Software to Work with Nginx-RTMP

Streaming applications typically have two fields for connection information. The first field is usually for the server information and the second field is usually for the stream name or key. The information that you should place into each field is listed. The stream name or key can be set to anything.

Field 1: rtmp://yourip/live/
Field 2: stream-key-you-set

To view streams open the following links in a player supporting RTMP.

rtmp://your ip/live/stream-key-you-set
rtmp://your ip/live360p/stream-key-you-set


http://stream.visit-x.tv/vxtv/live_720p/chunklist_w315623707.m3u8
http://stream.visit-x.tv/vxtv/live_360p/chunklist_w321146460.m3u8
http://oklivetv.com
http://adulttvchannels.ucoz.net
http://kino-live.xyz/715727871-egoist-tv.html
