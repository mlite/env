#!/bin/bash -x
### Build a docker image for debian i386.

### settings
arch=i386
suite=${1:-wheezy}
chroot_dir="/var/chroot/$suite"
apt_mirror="http://ftp.us.debian.org/debian"
docker_image="32bit/debian:$suite"

### make sure that the required tools are installed
apt-get install -y debootstrap dchroot
apt-get -t jessie-backports install -y docker.io

### install a minbase system with debootstrap
export DEBIAN_FRONTEND=noninteractive
debootstrap --arch $arch $suite $chroot_dir $apt_mirror

### update the list of package sources
cat <<EOF > $chroot_dir/etc/apt/sources.list
deb $apt_mirror $suite main contrib non-free
deb $apt_mirror $suite-updates main contrib non-free
deb http://security.debian.org/ $suite/updates main contrib non-free
EOF

### upgrade packages
chroot $chroot_dir apt-get update
chroot $chroot_dir apt-get upgrade -y
chroot $chroot_dir apt-get install -y locales
chroot $chroot_dir locale-gen en_US en_US.UTF-8
##chroot $chroot_dir dpkg-reconfigure locales
chroot $chroot_dir "export LC_CTYPE=en_US.UTF-8" >> /root/.bashrc
chroot $chroot_dir "export LC_ALL=en_US.UTF-8" >> /root/.bashrc

### install debian packages
chroot $chroot_dir apt-get install -y build-essential unzip cmake python
chroot $chroot_dir apt-get install -y libncurses5-dev zlib1g-dev libbsd-dev libffi-dev libgmp-dev libgmpxx4ldbl
chroot $chroot_dir apt-get install -y ghc cabal-install


### cleanup
chroot $chroot_dir apt-get autoclean
chroot $chroot_dir apt-get clean
chroot $chroot_dir apt-get autoremove

### install LLVM
cp llvm_install.sh $chroot_dir/root
chroot $chroot_dir sh /root/llvm_install.sh

### bootstrap ghc-7.8.3
chroot $chroot_dir cabal update
chroot $chroot_dir cabal install happy
chroot $chroot_dir cabal install alex
chroot $chroot_dir cabal install hoopl

### get and build ghc-7.8.3
cp ghc_cabal_install.sh $chroot_dir/root
chroot $chroot_dir sh /root/ghc_cabal_install.sh
#chroot $chroot_dir cabal install cabal-install

### create a tar archive from the chroot directory
tar cfz debian.tgz -C $chroot_dir .

### import this tar archive into a docker image:
cat debian.tgz | docker import - $docker_image

# ### push image to Docker Hub
# docker push $docker_image

### cleanup
rm debian.tgz
#rm -rf $chroot_dir
