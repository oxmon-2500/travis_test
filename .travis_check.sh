#/bin/bash
echo "------------------------------------------ .travis_check.sh ----------------------------------"
sudo apt-get update;
sudo apt-get install pip3; 
sudo find /usr /opt ! -type d -name "python3*" -ls;
sudo find /usr /opt ! -type d -name "pip3*" -ls;
PY3_PATH=$(sudo find /opt/python -name "python3")
PY3_PATH=${PY3_PATH:0:-8}
#/opt/python/3.6.3/bin/python3 --version;
export PATH=${PY3_PATH}:$PATH;
python3 --version
pip3 --version
echo "------------------------------------------ .travis_check.sh ----------------------------------"
