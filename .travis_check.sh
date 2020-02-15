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
  sudo find /usr /opt ! -type d -iname "QtCore" -ls
  sudo find /usr /opt -iname "Qt3Support" -ls
  #/usr/local/Cellar/qt@4/4.8.7_6/lib/Qt3Support.framework/Qt3Support -> Versions/4/Qt3Support
  #/usr/local/Cellar/qt@4/4.8.7_6/lib/Qt3Support.framework/Versions/4/Qt3Support
  #/usr/local/lib/QtCore.framework -> ../Cellar/qt@4/4.8.7_6/lib/QtCore.framework
  #/usr/local/Cellar/qt@4/4.8.7_6/lib/QtCore.framework/Versions/4/QtCore
  echo "----------------------ls -ls /usr/local/lib/Qt*---------------------------------------"
  ls -ls /usr/local/lib/Qt*
  clang++ --version
  #clang++ -DHAVE_CONFIG_H -I. -I..    -I../qucs-lib -I/usr/local/lib/QtCore.framework/Headers -I/usr/local/lib/QtGui.framework/Headers -I/usr/local/lib/QtXml.framework/Headers -I/usr/local/lib/QtSvg.framework/Headers -I/usr/local/lib/QtScript.framework/Headers -I/usr/local/lib/QtTest.framework/Headers -I/usr/local/lib/Qt3Support.framework/Headers -DQT_SHARED -DQT3_SUPPORT -DQT3_SUPPORT_WARNINGS -DQT_DEPRECATED_WARNINGS -std=c++0x  -g -O2 -c -o main.o main.cpp
  #clang++ -g -O2 -o qucs.real main.o qucs_.o -Wl,-bind_at_load  ./.libs/libqucsschematic.a -ldl -framework Qt3Support -framework QtTest -framework QtScript -framework QtSvg -framework QtXml -framework QtCore -framework QtGui
  clang++ -DHAVE_CONFIG_H -I. -I..  \
  -I../qucs-lib \
  -I/usr/local/lib/QtCore.framework/Headers \
  -I/usr/local/lib/QtGui.framework/Headers \
  -I/usr/local/lib/QtXml.framework/Headers \
  -I/usr/local/lib/QtSvg.framework/Headers \
  -I/usr/local/lib/QtScript.framework/Headers \
  -I/usr/local/lib/QtTest.framework/Headers \
  -I/usr/local/lib/Qt3Support.framework/Headers \
  -DQT_SHARED \
  -DQT3_SUPPORT \
  -DQT3_SUPPORT_WARNINGS \
  -DQT_DEPRECATED_WARNINGS \
  -std=c++0x  -g -O2 -c -o helloWorld.o helloWorld.cpp
  
  clang++ -g -O2 -o helloWorld.o -Wl,-bind_at_load  ./.libs/libqucsschematic.a \
  -ldl \
  -framework Qt3Support \
  -framework QtTest \
  -framework QtScript \
  -framework QtSvg \
  -framework QtXml \
  -framework QtCore \
  -framework QtGui
fi

echo "------------------------------------------ .travis_check.sh ----------------------------------"


# https://docs.brew.sh/Manpage

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



#Usage: brew install [options] formula
#Install formula. Additional options specific to formula may be appended to
#the command.
#Unless HOMEBREW_NO_INSTALL_CLEANUP is set, brew cleanup will then be run for
#the installed formulae or, every 30 days, for all formulae.
#    -d, --debug                      If brewing fails, open an interactive
#                                     debugging session with access to IRB or a
#                                     shell inside the temporary build directory.
#        --env                        If std is passed, use the standard build
#                                     environment instead of superenv. If super
#                                     is passed, use superenv even if the formula
#                                     specifies the standard build environment.
#        --ignore-dependencies        An unsupported Homebrew development flag to
#                                     skip installing any dependencies of any
#                                     kind. If the dependencies are not already
#                                     present, the formula will have issues. If
#                                     you're not developing Homebrew, consider
#                                     adjusting your PATH rather than using this
#                                     flag.
#        --only-dependencies          Install the dependencies with specified
#                                     options but do not install the formula
#                                     itself.
#        --cc                         Attempt to compile using the specified
#                                     compiler, which should be the name of the
#                                     compiler's executable, e.g. gcc-7 for GCC
#                                     7. In order to use LLVM's clang, specify
#                                     llvm_clang. To use the Apple-provided
#                                     clang, specify clang. This option will
#                                     only accept compilers that are provided by
#                                     Homebrew or bundled with macOS. Please do
#                                     not file issues if you encounter errors
#                                     while using this option.
#    -s, --build-from-source          Compile formula from source even if a
#                                     bottle is provided. Dependencies will still
#                                     be installed from bottles if they are
#                                     available.
#        --force-bottle               Install from a bottle if it exists for the
#                                     current or newest version of macOS, even if
#                                     it would not normally be used for
#                                     installation.
#        --include-test               Install testing dependencies required to
#                                     run brew test formula.
#        --devel                      If formula defines it, install the
#                                     development version.
#        --HEAD                       If formula defines it, install the HEAD
#                                     version, aka. master, trunk, unstable.
#        --fetch-HEAD                 Fetch the upstream repository to detect if
#                                     the HEAD installation of the formula is
#                                     outdated. Otherwise, the repository's HEAD
#                                     will only be checked for updates when a new
#                                     stable or development version has been
#                                     released.
#        --keep-tmp                   Retain the temporary files created during
#                                     installation.
#        --build-bottle               Prepare the formula for eventual bottling
#                                     during installation, skipping any
#                                     post-install steps.
#        --bottle-arch                Optimise bottles for the specified
#                                     architecture rather than the oldest
#                                     architecture supported by the version of
#                                     macOS the bottles are built on.
#    -f, --force                      Install without checking for previously
#                                     installed keg-only or non-migrated
#                                     versions.
#    -v, --verbose                    Print the verification and postinstall
#                                     steps.
#        --display-times              Print install times for each formula at the
#                                     end of the run.
#    -i, --interactive                Download and patch formula, then open a
#                                     shell. This allows the user to run
#                                     ./configure --help and otherwise
#                                     determine how to turn the software package
#                                     into a Homebrew package.
#    -g, --git                        Create a Git repository, useful for
#                                     creating patches to the software.
#    -h, --help                       Show this message.
