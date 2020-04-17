#/bin/bash
TRAVIS_OS_NAME=$1
echo "------------------------------------------ .travis_check_qt.sh ----------------------------------"
sudo find /usr /opt ! -type d -name "qmake" -ls
if [[ $TRAVIS_OS_NAME == linux ]]; then
  sudo apt-get update
  sudo apt-get install gnucap
  sudo apt-get install gnucap-dev
  gnucap --version
fi

