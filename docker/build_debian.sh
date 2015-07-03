#!/bin/bash -x
### Build a docker image for debian i386.

### settings
arch=i386
suite=${1:-wheezy}
chroot_dir="/var/chroot/$suite"
apt_mirror="http://ftp.us.debian.org/debian"
docker_image="32bit/debian:$suite"

### make sure that the required tools are installed
apt-get update
apt-get install -y debootstrap dchroot
apt-get -t jessie-backports install -y docker.io

### install a minbase system with debootstrap
export DEBIAN_FRONTEND=noninteractive
debootstrap --arch $arch $suite $chroot_dir $apt_mirror
echo "proc $chroot_dir/proc proc defaults 0 0" >> /etc/fstab
mount proc $chroot_dir/proc -t proc
echo "sysfs $chroot_dir/sys sysfs defaults 0 0" >> /etc/fstab
mount sysfs $chroot_dir/sys -t sysfs
cp /etc/hosts $chroot_dir/etc/hosts
#cp /proc/mounts $chroot_dir/etc/mtab

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
chroot $chroot_dir dpkg-reconfigure locales

### install debian packages
chroot $chroot_dir apt-get install -y build-essential unzip cmake python
chroot $chroot_dir apt-get install -y libncurses5-dev zlib1g-dev libbsd-dev libffi-dev libgmp-dev libgmpxx4ldbl
chroot $chroot_dir apt-get install -y libtool git 


### cleanup
chroot $chroot_dir apt-get autoclean
chroot $chroot_dir apt-get clean
chroot $chroot_dir apt-get autoremove

### install build enviroment
cp install_env.sh $chroot_dir/root
chroot $chroot_dir sh /root/llvm_install.sh

### create a tar archive from the chroot directory
tar cfz debian.tgz -C $chroot_dir .

### import this tar archive into a docker image:
cat debian.tgz | docker import - $docker_image

# ### push image to Docker Hub
# docker push $docker_image

### cleanup
rm debian.tgz
#rm -rf $chroot_dir
