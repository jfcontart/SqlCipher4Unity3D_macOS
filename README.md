# SqlCipher4Unity3D_macOS

SqlCipher4Unity3D build bundle for macOS© (OSX). Use with https://github.com/netpyoung/SqlCipher4Unity3D .

 # macOS©

You need :
- be on macOS
- install xcode
- install xcode as command

## Use the SQLCipherBuilt.sh

Use the SQLCipherBuilt.sh :
```
cd <this directory>
./SQLCipher.sh <version example:4.3.0>
```

## Compile SQLCipher 4.3.0 from sources
Open terminal and create directory to work.
```
mkdir /tmp/SQLCipherMacOS
cd /tmp/SQLCipherMacOS/
```
## Get Sources

```
cd /tmp/SQLCipherMacOS/
git clone https://github.com/sqlcipher/sqlcipher.git
```

## Prepare compile option

- See https://www.sqlite.org/compile.html for the flags.
- Use **-framework Security** to compile with macOS **commoncrypto**. 
- Need **-framework Foundation** to include the **CoreFoundation**.

```
cd /tmp/SQLCipherMacOS/sqlcipher/
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

```
## Copy on desktop

```
ls /tmp/SQLCipherMacOS/sqlcipher/.libs/
mkdir ~/Desktop/SQLCipherMacOS
cp /tmp/SQLCipherMacOS/sqlcipher/.libs/libsqlcipher.0.dylib ~/Desktop/SQLCipherMacOS/sqlcipher.bundle
cp /tmp/SQLCipherMacOS/sqlcipher/.libs/libsqlcipher.a ~/Desktop/SQLCipherMacOS/libsqlcipher.a
open ~/Desktop/SQLCipherMacOS
```

## Clean
 
```
rm -r /tmp/SQLCipherMacOS/*
rm -r /tmp/SQLCipherMacOS
```

## Copy sqlcipher.bundle in project

Copy in "MacOS" folder in Unity3D, select file and check in "Inspector" :

On select **platforms for plugin**
- Set "Editor" - yes
- Set "Standalone" - yes

On tab **unity**
- Set "CPU" - Any CPU
- Set "OS" - OSX

On tab **standalone**
- Set "X64" - yes
