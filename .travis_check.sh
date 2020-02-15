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
  brew cleanup
  brew tap cartr/qt4
  brew tap-pin cartr/qt4
  brew install qt@4
  echo "---------------------------------brew --help -------------------------------------"
  brew --help
  echo "---------------------------------brew instal --help -------------------------------------"
  brew install --help
  sudo find /usr /opt -iname "*Qt3Support*" -ls
  #/usr/local/Cellar/qt@4/4.8.7_6/lib/Qt3Support.framework/Qt3Support -> Versions/4/Qt3Support
  #/usr/local/Cellar/qt@4/4.8.7_6/lib/Qt3Support.framework/Versions/4/Qt3Support
  clang++ --version
  #clang++ -DHAVE_CONFIG_H -I. -I..    -I../qucs-lib -I/usr/local/lib/QtCore.framework/Headers -I/usr/local/lib/QtGui.framework/Headers -I/usr/local/lib/QtXml.framework/Headers -I/usr/local/lib/QtSvg.framework/Headers -I/usr/local/lib/QtScript.framework/Headers -I/usr/local/lib/QtTest.framework/Headers -I/usr/local/lib/Qt3Support.framework/Headers -DQT_SHARED -DQT3_SUPPORT -DQT3_SUPPORT_WARNINGS -DQT_DEPRECATED_WARNINGS -std=c++0x  -g -O2 -c -o main.o main.cpp
  #clang++ -g -O2 -o qucs.real main.o qucs_.o -Wl,-bind_at_load  ./.libs/libqucsschematic.a -ldl -framework Qt3Support -framework QtTest -framework QtScript -framework QtSvg -framework QtXml -framework QtCore -framework QtGui
fi

echo "------------------------------------------ .travis_check.sh ----------------------------------"



#Example usage:
#  brew search [TEXT|/REGEX/]
#  brew info [FORMULA...]
#  brew install FORMULA...
#  brew update
#  brew upgrade [FORMULA...]
#  brew uninstall FORMULA...
#  brew list [FORMULA...]
#Troubleshooting:
#  brew config
#  brew doctor
#  brew install --verbose --debug FORMULA
#Contributing:
#  brew create [URL [--no-fetch]]
#  brew edit [FORMULA...]
#Further help:
#  brew commands
#  brew help [COMMAND]
#  man brew
#  https://docs.brew.sh
