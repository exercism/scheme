## Installing Scheme

Install [Chez Scheme](https://cisco.github.io/ChezScheme/), a free,
open-source scheme implementation available on a variety of
platforms. The link provides binaries as well as source releases. 

### Build From Source

Clone the git repository and once downloaded, building the compiler
should take less than a minute.

```bash
git clone git@github.com:cisco/ChezScheme.git && cd ChezScheme && ./configure && make && make install
```
### OS X

Install via Homebrew:

```bash
brew install chezscheme
```

### GNU/Linux

#### Nix package manager

``` bash
nix-env -i chez-scheme
```

#### Debian/Ubuntu

```bash
sudo apt-get install chezscheme
```



