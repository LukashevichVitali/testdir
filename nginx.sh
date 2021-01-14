yum install -y gcc gcc-c++ git

sudo -u vagrant /bin/sh <<\vagrant_block

wget https://nginx.org/download/nginx-1.19.6.tar.gz
tar -xvf nginx-1.19.6.tar.gz
wget https://ftp.pcre.org/pub/pcre/pcre-8.44.tar.gz
tar -xvf pcre-8.44.tar.gz
wget https://www.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz
tar -xvf openssl-1.0.2u.tar.gz
git clone git://github.com/vozlt/nginx-module-vts.git

cd nginx-1.19.6

./configure \
    --prefix=/home/vagrant/nginx \
    --sbin-path=/home/vagrant/nginx/sbin/nginx \
    --conf-path=/home/vagrant/nginx/conf/nginx.conf \
    --error-log-path=/home/vagrant/nginx/logs/error.log \
    --http-log-path=/home/vagrant/nginx/logs/access.log \
    --pid-path=/home/vagrant/nginx/logs/nginx.pid \
    --user=vagrant \
    --with-http_ssl_module \
    --with-http_realip_module \
    --without-http_gzip_module \
    --add-module=/home/vagrant/nginx-module-vts \
    --with-pcre=/home/vagrant/pcre-8.44 \
    --with-openssl=/home/vagrant/openssl-1.0.2u
make
make install
cd ..

sudo cp /vagrant/nginx.service /etc/systemd/system
cp /vagrant/nginx.conf /home/vagrant/nginx/conf
cp /vagrant/backend.conf /home/vagrant/nginx/conf/vhosts/
cp /vagrant/html.tar.gz /home/vagrant
tar -xvf html.tar.gz
cp -r html/* nginx/html
printf "admin:$(openssl passwd -crypt nginx)\n" > /home/vagrant/nginx/conf/.htpasswd
nginx/sbin/nginx -c conf/nginx.conf
vagrant_block

#chown -R vagrant:vagrant /home/vagrant/nginx

#systemctl daemon-reload
#systemctl start nginx




