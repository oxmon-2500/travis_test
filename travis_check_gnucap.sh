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
  echo "--------------------------showTree $1"
  find $1 -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"
  #find $1 -type f -ls
}
function inst_boost(){
  echo "----------------------------------------boost-----------------------"
  wget https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.gz
  tar -xf boost_*.tar.gz
  pushd boost_*
  ./bootstrap.sh >> ${DIST_LOG}
  ./b2           >/dev/null # >> ${DIST_LOG}
  if [ ! -d ${DIST_LOCAL}/include ]; then mkdir -p ${DIST_LOCAL}/include; fi
  cp -r boost ${DIST_LOCAL}/include
  popd #boost_*
}
function inst_gnucap(){
  echo "----------------------------------------gnucap--------------------------"
  git clone -q git://git.sv.gnu.org/gnucap.git >> ${DIST_LOG}
  pushd gnucap
  git checkout develop
  ./configure --prefix=${DIST_LOCAL}
  make         >> ${DIST_LOG}
  make check   >> ${DIST_LOG}
  make install
  showTree ${DIST_LOCAL}
  popd # gnucap
  
  echo "--------------------------------------------------------------------${LD_LIBRARY_PATH}---"
  export LD_LIBRARY_PATH=${DIST_LOCAL}/lib:${LD_LIBRARY_PATH}
  if [ -f ${DIST_LOCAL}/bin/gnucap ]; then 
    ${DIST_LOCAL}/bin/gnucap < ${START_DIR}/gnucap_cmd.txt # exit immediatly
  else
    showTree ${DIST_LOCAL}
  fi
}

function inst_gsl(){
  echo "----------------------------------------gsl-GNU Scientific Library -------------------------"
  #wget ftp://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz
  # mirrors
  #wget http://mirror.easyname.at/gnu/gsl/gsl-2.6.tar.gz
  wget http://mirror.kumi.systems/gnu/gsl/gsl-2.6.tar.gz
  #
  tar -zxf gsl-*.*.tar.gz
  pushd gsl-*
  ./configure --prefix=${DIST_LOCAL}  >> ${DIST_LOG}    
  make   >> ${DIST_LOG}
  #make check
  make install >> ${DIST_LOG}
  showTree ${DIST_LOCAL}
  popd # gsl
}
function inst_blas(){
  echo "----------------------------------------blas---Basic Linear Algebra Subprograms-----------------------"
  #sudo apt-get install gcc-gfortran
  # sudo apt-get install gfortran # Package gfortran is not available, but is referred to by another package.
  # sudo apt-get install libblas-dev checkinstall
  # CBLAS is C interface to the BLAS library
  # https://www.netlib.org/blas/blas-3.8.0.tgz ??
  git clone -q https://github.com/xianyi/OpenBLAS.git
  pushd OpenBLAS
  make FC=gfortran >> ${DIST_LOG}
  make PREFIX=${DIST_LOCAL} install >> ${DIST_LOG}
  showTree ${DIST_LOCAL}
  popd # OpenBLAS
}

function inst_gnucsator(){
  echo "----------------------------------------gnucsator-----------------------"
  export PATH=${DIST_LOCAL}/bin:$PATH; # make gnucap-conf available
  git clone -q https://github.com/Qucs/gnucsator.git
  pushd gnucsator
  find DIST_LOCAL -name "libgsl*" -ls
  find DIST_LOCAL -name "libblas*" -ls
  find DIST_LOCAL -name "libgnucap*" -ls
  #git checkout develop
  # ------------- overwrite ----------------begin
  cp $START_DIR/configure .   # overwrite original    !!!!!!!!!!!!!!
  cp $START_DIR/Makefile.in . # overwrite original    !!!!!!!!!!!!!!
  # ------------- overwrite ----------------end
  ./configure --prefix=${DIST_LOCAL}    
  make all || travis_terminate 1;
  make install || travis_terminate 2;
  showTree ${DIST_LOCAL}
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
  sudo apt-get install gcc # for installing also gfortran
  gfortran --version || travis_terminate 1;

  mkdir sources
  pushd sources
  
  inst_boost
  inst_gnucap
  inst_gsl
  inst_blas
  inst_gnucsator
  
  popd # sources
  
  echo "--------------------------------------pwd:$(pwd)--------------------------------------"
    
  cmake --version # 20200417;       cmake version 3.12.4
  ls -l ${DIST_LOCAL}
fi

