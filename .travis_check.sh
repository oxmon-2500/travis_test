#/bin/bash
TRAVIS_OS_NAME=$1
echo "------------------------------------------ .travis_check.sh ----------------------------------"
sudo find /usr /opt ! -type d -name "python3*" -ls
sudo find /usr /opt ! -type d -name "pip3*" -ls
if [[ $TRAVIS_OS_NAME == linux ]]; then
  sudo apt-get update
  sudo apt-get install pip3
  PY3_PATH=$(sudo find /opt/python -name "python3")
  # /opt/python/3.6.3/bin/python3 --> /opt/python/3.6.3/bin
  PY3_PATH=${PY3_PATH:0:-8}
  export PATH=${PY3_PATH}:$PATH;
fi
python3 --version
pip3 --version

if [[ $TRAVIS_OS_NAME == osx ]]; then
  brew tap cartr/qt4
  brew tap-pin cartr/qt4
  brew install qt@4
  brew install libqt4-qt3support
fi
sudo find /usr /opt -iname "*Qt3Support*" -ls
echo "------------------------------------------ .travis_check.sh ----------------------------------"
