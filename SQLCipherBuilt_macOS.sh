#!/usr/bin/env bash

if [ "$#" -ne 1 ]
then
    echo "Usage:"
    echo "./SQLCipherBuilt.sh <VERSION>"
    exit 1
fi

VERSION=$1

#prepare dir to compile

mkdir ./tmp
mkdir ./tmp/${VERSION}

cd ./tmp/${VERSION}/

#Download sources files from SQLCipher

curl -OL https://github.com/sqlcipher/sqlcipher/archive/v${VERSION}.tar.gz
tar -xvf v${VERSION}.tar.gz
cd sqlcipher-${VERSION}

#Compile

make clean

./configure \
--enable-tempstore=no \
--enable-load-extension \
--disable-tcl \
CFLAGS="\
-arch x86_64 \
-mmacos-version-min=10.10 \
" \
LDFLAGS="\
-framework Security \
-framework Foundation \
"

make

#Copy result

cd ..
cd ..
cd .. 

mkdir ./${VERSION}
mkdir ./${VERSION}/macOS
rm  ./${VERSION}/macOS/libsqlcipher.0.dylib

cp ./tmp/${VERSION}/sqlcipher-${VERSION}/.libs/libsqlcipher.0.dylib ./${VERSION}/macOS/sqlcipher.bundle

#open ./${VERSION}

#Clean 

rm -r ./tmp/


