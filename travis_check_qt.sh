#/bin/bash
TRAVIS_OS_NAME=$1
echo "------------------------------------------ .travis_check_qt.sh ----------------------------------"
sudo find /usr /opt ! -type d -name "qmake" -ls
if [[ $TRAVIS_OS_NAME == linux ]]; then
  sudo apt-get update
  sudo apt-get install qt4
fi

if [[ $TRAVIS_OS_NAME == osx ]]; then
  brew cleanup
  brew tap cartr/qt4
  brew tap-pin cartr/qt4
  brew install qt@4
  qmake --version # Qt version #Using Qt version 4.8.7 in /usr/local/lib
  sudo find /usr /opt -iname "*Qt3Support*" -ls
  #echo "---------------------------------brew --help -------------------------------------"
  #brew --help
  #echo "---------------------------------brew instal --help -------------------------------------"
  #brew install --help
  sudo find /usr /opt ! -type d -iname "QtCore" -ls
  sudo find /usr /opt -iname "Qt3Support" -ls
  #/usr/local/Cellar/qt@4/4.8.7_6/lib/Qt3Support.framework/Qt3Support -> Versions/4/Qt3Support
  #/usr/local/Cellar/qt@4/4.8.7_6/lib/Qt3Support.framework/Versions/4/Qt3Support
  #/usr/local/lib/QtCore.framework -> ../Cellar/qt@4/4.8.7_6/lib/QtCore.framework
  #/usr/local/Cellar/qt@4/4.8.7_6/lib/QtCore.framework/Versions/4/QtCore
  echo "----------------------ls -ls /usr/local/lib/Qt*---------------------------------------"
  # 0 lrwxr-xr-x  1 travis  admin  47 Feb 23 20:31 /usr/local/lib/Qt3Support.framework 
  ls -ls /usr/local/lib/Qt* | awk '{print $2, $10}'
  
  clang++ --version
  #clang++ -DHAVE_CONFIG_H -I. -I..    -I../qucs-lib -I/usr/local/lib/QtCore.framework/Headers -I/usr/local/lib/QtGui.framework/Headers -I/usr/local/lib/QtXml.framework/Headers -I/usr/local/lib/QtSvg.framework/Headers -I/usr/local/lib/QtScript.framework/Headers -I/usr/local/lib/QtTest.framework/Headers -I/usr/local/lib/Qt3Support.framework/Headers -DQT_SHARED -DQT3_SUPPORT -DQT3_SUPPORT_WARNINGS -DQT_DEPRECATED_WARNINGS -std=c++0x  -g -O2 -c -o main.o main.cpp
  #clang++ -g -O2 -o qucs.real main.o qucs_.o -Wl,-bind_at_load  ./.libs/libqucsschematic.a -ldl -framework Qt3Support -framework QtTest -framework QtScript -framework QtSvg -framework QtXml -framework QtCore -framework QtGui
  echo "----------------- clang -----------------------------------"
  cd cpp
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
  echo "----------------- linker -----------------------------------"
  export QT_LIBS=/usr/local/lib
  clang++ -g -O2 -o helloWorld.o \
  -ldl \
  -framework Qt3Support \
  -framework QtTest \
  -framework QtScript \
  -framework QtSvg \
  -framework QtXml \
  -framework QtCore \
  -framework QtGui
  cd ..
fi

echo "------------------------------------------ .travis_check_qt.sh ----------------------------------"


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
