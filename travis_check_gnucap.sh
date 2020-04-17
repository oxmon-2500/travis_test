#/bin/bash
TRAVIS_OS_NAME=$1
echo "------------------------------------------ $0 ----------------------------------"
sudo find /usr /opt ! -type d -name "qmake" -ls
if [[ $TRAVIS_OS_NAME == linux ]]; then
  #sudo apt-get update
  #sudo apt-get install gnucap
  #sudo apt-get install gnucap-dev
  #gnucap < gnucap_cmd.txt # exit immediatly
  echo "-------------------------username:$USERNAME"
  echo "-------------------------pwd:$(pwd)"
  mkdir sources
  push sources
  echo "----------------------------------------gnucap--------------------------"
  git clone git://git.sv.gnu.org/gnucap.git 
  pushd gnucap
  git checkout develop
  ./configure --prefix=local/gnucap
  make
  make check
  make install
  local/gnucap/bin/gnucap < gnucap_cmd.txt # exit immediatly
  popd # gnucap
  
  echo "----------------------------------------gsl--------------------------"
  wget ftp://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz
  tar -zxf gsl-*.*.tar.gz
  pushd gsl-*
  ./configure --prefix=local/gsl
  make
  #make check
  make install
  popd # gsl
  
  popd # sources
  
  cmake --version # 20200417;       cmake version 3.12.4
fi

