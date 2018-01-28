## Installing Scheme

Install [Guile Scheme](http://www.gnu.org/software/guile/), a free, open-source scheme implementation available on a variety of platforms.

### OS X

Install via Homebrew:

```bash
brew install guile
```

### Linux

On most Linux distros, Guile is probably already installed as it's the official
GNU extension language. If not, in most cases, you can use your distro's package manager to install it.

#### Debian

```bash
sudo apt-get install guile
```

#### Arch

```bash
pacman -S guile
```

#### Ubuntu 14.04

The Guile packages for Ubuntu 14.04 are missing modules that prevent the tests
from running. Guile can be installed from source under your home directory by
following the instructions below.

```bash
sudo apt-get install libltdl-dev libunistring-dev libgc-dev libmpd-dev libgmp3-dev libffi-dev
cd $HOME/Downloads/
wget ftp://ftp.gnu.org/gnu/guile/guile-2.0.11.tar.gz
tar -zxvf guile-2.0.11.tar.gz
cd guile-2.0.11/
./configure --prefix=$HOME/lib/guile
make
make install
if [ ! -d $HOME/bin ]; then mkdir $HOME/bin; fi
ln -s $HOME/lib/guile/bin/guile $HOME/bin/guile
```
After installation is complete you will need to log out and back into ubuntu
in order for the path to be set on your /home/bin directory.

#### Ubuntu 16.04

```bash
sudo apt install guile-2.0
```

### Windows

Guile can theoretically be compiled from source under
[Cygwin](https://www.cygwin.com/), but as with many things, it's probably easier
just to run a Linux VM.

You shouldn't need any "extra" packages.
