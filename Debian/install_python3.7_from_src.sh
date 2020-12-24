sudo apt-get install -y libreadline-gplv2-dev \
     libncursesw5-dev \
     libssl-dev \
     libsqlite3-dev \
     tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev


cd /usr/src
wget https://www.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz
tar -xvf openssl-1.0.2u.tar.gz
cd openssl-1.0.2u
./config --shared --prefix=/usr/local/openssl --openssldir=/usr/local/openssl
make
make install

export LD_LIBRARY_PATH=/usr/local/openssl/lib

cd /usr/src
sudo wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz

sudo tar xzf Python-3.7.4.tgz

cd Python-3.7.4
sudo ./configure --enable-optimizations --with-openssl=/usr/local/openssl
sudo make altinstall
