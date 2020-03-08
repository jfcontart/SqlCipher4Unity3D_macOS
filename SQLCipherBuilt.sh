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
cd ./tmp/${VERSION}/sqlcipher-${VERSION}/

#Compile

make clean
./configure \
--enable-tempstore=no \
--disable-tcl \
--with-crypto-lib=commoncrypto \
CFLAGS="\
-DSQLITE_HAS_CODEC \
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

cp ./tmp/${VERSION}/sqlcipher-${VERSION}/.libs/libsqlcipher.0.dylib ./${VERSION}sqlcipher.bundle
open ./${VERSION}sqlcipher.bundle

#Clean 

rm -r ./tmp/

