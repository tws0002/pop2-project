Maya 2012 and OpenSSL   libssl.so.6  dependency

Maya is built on RHEL5.1 with a number of dependent components.
Some of these components have runtime library dependencies on  libssl.so.6 and libcrypto.so.6
 
Some Linux distributions may not have system libraries with the  *.so.6 version.   
Usually will be more recent releases.

Fedora 10    libssl.so.7
Fedora 11    libssl.so.8
Fedora 12    libssl.so.10
Fedora 13    libssl.so.10
Fedora 14    libssl.so.10

The Maya installer will attempt locating the system libraries, if found, symlink/copy them to
the Maya lib directory as   *.so.6 versions.  If that fails then pre-built versions of libssl.so.6
and libcrypto.so.6  are located in this directory that can be used. Copy these files to the Maya lib
directory.

Else obtaining a compatible version of openssl from you distro can be tried or downloading and building 
from source   http://www.openssl.org

RHEL 6  comes with a compatibility rpm package

openssl098e-0.9.8e-17.el6.x86_64

that should be installed to obtain the libssl.so.6 and  libcrypto.so.6   files

as root

yum install openssl098e-0.9.8e


