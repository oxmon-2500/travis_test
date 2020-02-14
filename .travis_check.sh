#/bin/bash
echo "------------------------------------------ .travis_check.sh ----------------------------------"
      sudo apt-get update;
      sudo apt-get install pip3; 
      sudo find /usr /opt ! -type d -name "python3*" -ls;
      sudo find /usr /opt ! -type d -name "pip3*" -ls;
      /opt/python/3.6.3/bin/python3 --version;
      export PATH=/opt/python/3.6.3/bin:$PATH;
echo "------------------------------------------ .travis_check.sh ----------------------------------"
