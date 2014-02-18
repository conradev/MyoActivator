#!/bin/bash

# The only tool used here that is not included with OS X is `lzma`.
# It is only used when extracting packages with LZMA data compression.

echo "Downloading list of packages..."
REPOS=('http://apt.thebigboss.org/repofiles/cydia'); # Others, such as ModMyi can be added here
for i in "${!REPOS[@]}"; do
  curl -s -L "${REPOS[i]}/dists/stable/main/binary-iphoneos-arm/Packages.bz2" | bzcat -- >> "Packages.${i}"
done

download() {
  echo " Downloading $1..."
  for i in "${!REPOS[@]}"; do
    PACKAGE_URL=$(grep "$1.*\.deb$" Packages.${i} | awk '{print $2}')
    if [ -n "$PACKAGE_URL" ]; then
      PACKAGE_URL="${REPOS[i]}/$PACKAGE_URL"
      PACKAGE=$(basename $PACKAGE_URL)
      curl -s -L "$PACKAGE_URL" > $PACKAGE
      shift
      if [ -n "$(ar -t $PACKAGE | grep data.tar.lzma)" ]; then
        ar -p $PACKAGE data.tar.lzma | tar --lzma -xf - ${@}
      else
        ar -p $PACKAGE data.tar.gz | tar xzf - ${@}
      fi
      rm $PACKAGE
    fi
  done
}

download 'libactivator' './usr/lib/libactivator.dylib' './usr/include/libactivator/*'

if [ -d "$PWD/theos" ]; then
  THEOS=$PWD/theos
fi

echo "Installing libraries into $THEOS"
cp -rf $PWD/usr/include/* $THEOS/include/
cp -rf $PWD/usr/lib/* $THEOS/lib/
rm -r usr

rm Packages.*
