#/bin/bash
TRAVIS_OS_NAME=$1
echo "------------------------------------------ .travis_check.sh ----------------------------------"
if [[ $TRAVIS_OS_NAME == linux ]]; then
  sudo apt-get update
  sudo apt-get install pip3
fi
sudo find /usr /opt ! -type d -name "python3*" -ls;
sudo find /usr /opt ! -type d -name "pip3*" -ls;
PY3_PATH=$(sudo find /opt/python -name "python3")
# /opt/python/3.6.3/bin/python3 --> /opt/python/3.6.3/bin
PY3_PATH=${PY3_PATH:0:-8}
export PATH=${PY3_PATH}:$PATH;
python3 --version
pip3 --version

sudo find /usr /opt ! -type d -name "*Qt3Support*" -ls;
echo "------------------------------------------ .travis_check.sh ----------------------------------"
