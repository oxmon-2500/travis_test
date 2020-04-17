#/bin/bash
TRAVIS_OS_NAME=$1
echo "------------------------------------------ $0 ----------------------------------"
DIST_LOCAL=~/local
DIST_LOG=~/dist_log.log
START_DIR=$(pwd);#/home/travis/build/oxmon-2500/travis_test

function sysInfo(){
  echo "--------------------------sysInfo------------------------"
  #sudo find /usr /opt ! -type d -name "qmake" -ls
}

function showTree(){
  find $1 -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"
}
function instGnucap(){
  echo "----------------------------------------gnucap--------------------------"
  git clone git://git.sv.gnu.org/gnucap.git >> ${DIST_LOG}
  pushd gnucap
  git checkout develop
  ./configure --prefix=${DIST_LOCAL}/gnucap
  make  >> ${DIST_LOG}
  make check
  make install
  showTree ${DIST_LOCAL}/gnucap
  popd # gnucap
}

function instGsl(){
  echo "----------------------------------------gsl-GNU Scientific Library -------------------------"
  wget ftp://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz
  tar -zxf gsl-*.*.tar.gz
  pushd gsl-*
  ./configure --prefix=${DIST_LOCAL}/gsl  >> ${DIST_LOG}    
  make   >> ${DIST_LOG}
  #make check
  make install
  popd # gsl
}
function instBlas(){
  echo "----------------------------------------blas---Basic Linear Algebra Subprograms-----------------------"
  # sudo apt-get install gfortran # Package gfortran is not available, but is referred to by another package.
  # sudo apt-get install libblas-dev checkinstall
  # CBLAS is C interface to the BLAS library
  # https://www.netlib.org/blas/blas-3.8.0.tgz ??
  git clone https://github.com/xianyi/OpenBLAS.git
  pushd OpenBLAS
  make >> ${DIST_LOG}
  make PREFIX=${DIST_LOCAL}/blas install
  popd # OpenBLAS
}

function instGnucsator(){
  echo "----------------------------------------blas---Basic Linear Algebra Subprograms-----------------------"
  git clone https://github.com/Qucs/gnucsator.git
  pushd gnucsator
  git checkout develop
  ./configure --prefix=${DIST_LOCAL}/gnucsator
  make
  make install
  popd #gnucsator
}

if [[ $TRAVIS_OS_NAME == linux ]]; then
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
  # sudo apt-get install tree   # E: Unable to locate package tree
  echo "-------------------------username:$USER" # travis
  echo "-------------------------pwd:$(pwd)"     # /home/travis/build/${USER}/travis_test
  mkdir sources
  pushd sources
  instGnucap
  echo "--------------------------------------------------------------------${LD_LIBRARY_PATH}---"
  export LD_LIBRARY_PATH=${DIST_LOCAL}/gnucap/lib:${LD_LIBRARY_PATH}
  if [ -f ${DIST_LOCAL}/gnucap/bin/gnucap ]; then 
    ${DIST_LOCAL}/gnucap/bin/gnucap < ${START_DIR}/gnucap_cmd.txt # exit immediatly
  else
    showTree ${DIST_LOCAL}/gnucap
  fi
  
  instGsl

  instBlas
  
  instGnucsator
  
  popd # sources
  
  echo "--------------------------------------pwd:$(pwd)--------------------------------------"
    
  cmake --version # 20200417;       cmake version 3.12.4
  ls -l ${DIST_LOCAL}
fi

