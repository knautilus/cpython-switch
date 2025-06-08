set -e

export DEVKITPRO=/opt/devkitpro
export RENPY_VER=7.6.3
export PYGAME_SDL2_VER=2.1.0

apt-get -y update
apt-get -y upgrade

apt -y install build-essential checkinstall
apt -y install libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev

apt -y install python2 python2-dev

python2 --version

curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
python2 get-pip.py
pip2 --version

apt-get -y install p7zip-full libsdl2-dev libsdl2-image-dev libjpeg-dev libpng-dev libsdl2-ttf-dev libsdl2-mixer-dev libavformat-dev libfreetype6-dev libswscale-dev libglew-dev libfribidi-dev libavcodec-dev  libswresample-dev libsdl2-gfx-dev libgl1-mesa-glx
pip2 uninstall distribute
pip2 install future six typing requests ecdsa pefile==2019.4.18 Cython==0.29.36 setuptools==0.9.8

apt -y install build-essential checkinstall

curl -LOC - https://github.com/knautilus/Utils/releases/download/v1.0/devkitpro-pkgbuild-helpers-2.2.4-2-any.pkg.tar.xz
dkp-pacman -U --noconfirm devkitpro-pkgbuild-helpers-2.2.4-2-any.pkg.tar.xz
rm devkitpro-pkgbuild-helpers-2.2.4-2-any.pkg.tar.xz

git clone --branch v2.7.16 --single-branch https://github.com/python/cpython.git

pushd cpython
patch -p1 < ../cpython.patch
popd

/bin/bash -c 'sed -i'"'"'.bak'"'"' '"'"'s/set(CMAKE_EXE_LINKER_FLAGS_INIT "/set(CMAKE_EXE_LINKER_FLAGS_INIT "-fPIC /'"'"' $DEVKITPRO/cmake/Switch.cmake'
