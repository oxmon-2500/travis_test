#/bin/bash
TRAVIS_OS_NAME=$1
echo "------------------------------------------ $0 ----------------------------------"
sudo find /usr /opt ! -type d -name "qmake" -ls
if [[ $TRAVIS_OS_NAME == linux ]]; then
  DIST_LOCAL=~/local
  DIST_LOG=~/dist_log.log
  #sudo apt-get update
  #sudo apt-get install gnucap
  #sudo apt-get install gnucap-dev
  
  #- apt install gnucap # (in debian>=buster)
  #- apt install libgnucap-dev
  #install some other dependencies
  #- apt install libboost-all-dev # (this is a superset)
  #- apt install libgsl-dev
  #- apt install libblas-dev
  #- apt install numdiff # used in "make check"
  echo "-------------------------username:$USER"
  echo "-------------------------pwd:$(pwd)"
  mkdir sources
  push sources
  echo "----------------------------------------gnucap--------------------------"
  git clone git://git.sv.gnu.org/gnucap.git >> ${DIST_LOG}
  pushd gnucap
  git checkout develop
  ./configure --prefix=${DIST_LOCAL}/gnucap
  make
  make check
  make install
  ${DIST_LOCAL}/gnucap/bin/gnucap < ~/gnucap_cmd.txt # exit immediatly
  popd # gnucap
  
  echo "----------------------------------------gsl-GNU Scientific Library -------------------------"
  wget ftp://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz
  tar -zxf gsl-*.*.tar.gz
  pushd gsl-*
  ./configure --prefix=${DIST_LOCAL}/gsl
  make
  #make check
  make install
  popd # gsl
  
  echo "----------------------------------------blas--------------------------"
  
  popd # sources
  
  cmake --version # 20200417;       cmake version 3.12.4
fi

