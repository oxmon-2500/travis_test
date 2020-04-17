#/bin/bash
TRAVIS_OS_NAME=$1
echo "------------------------------------------ $0 ----------------------------------"
sudo find /usr /opt ! -type d -name "qmake" -ls
if [[ $TRAVIS_OS_NAME == linux ]]; then
  #sudo apt-get update
  sudo apt-get install gnucap
  #sudo apt-get install gnucap-dev
  gnucap < gnucap_cmd.txt # exit immediatly
  wget ftp://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz
  tar -zxvf gsl-*.*.tar.gz
  pushd gsl-*
  echo "-------------------------username:$USERNAME"
  ./configure --prefix=/home/$USERNAME/local/gsl
  make
  make check
  make install
  cmake --version
fi

