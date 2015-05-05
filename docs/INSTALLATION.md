## Installing Scheme

Install [Guile Scheme](http://www.gnu.org/software/guile/), a free, open-source scheme implementation available on a variety of platforms.

**OS X**

Install via Homebrew:

```bash
brew install guile
```

**Linux**

On most Linux distros, Guile is probably already installed as it's the official
GNU extension language. If not, use your distro's package manager to install, e.g.:

Debian:
```bash
sudo apt-get install guile
```

Arch:
```bash
pacman -S guile
```

**Windows**

Guile can theoretically be compiled from source under [Cygwin](https://www.cygwin.com/), but as with
many things, it's probably easier just to run a Linux VM.

You shouldn't need any "extra" packages.
