# MyoActivator

Integrates [Myo](https://www.thalmic.com/en/myo/) with [Activator](https://github.com/rpetrich/libactivator) so that you can use hand gestures to control your jailbroken iOS device.

This project is based off of [PebbleActivator](https://github.com/rpetrich/PebbleActivator).

## Getting Started

### Prequisites

- [Xcode 5](https://itunes.apple.com/app/xcode/id497799835), which includes the iOS 7 SDK
- A jailbroken device running iOS 5 or later
- Myo SDK for iOS
- Myo

### Building

The first step to build the project is to clone the repository and initialize all of its submodules:

``` sh
git clone git://github.com/conradev/MyoActivator.git
cd MyoActivator
git submodule update --init
```

The next step is to download the dependencies:
``` sh
./get_libraries.sh
```

To build the project, you need only run:

```
make MYO_FRAMEWORK_PATH=/path/to/MyoKit.embeddedframework
```

### Installing

To install this on a jailbroken device, some additional tools are needed.

The first tool is `ldid`, which is used for fakesigning binaries. Ryan Petrich has a build on his [Github mirror](https://github.com/rpetrich/ldid):

``` sh
curl -O http://cloud.github.com/downloads/rpetrich/ldid/ldid.zip
unzip ldid.zip
mv ldid theos/bin/
rm ldid.zip
```

To build a Debian package, `dpkg` is required. You can install it from [Homebrew](http://mxcl.github.com/homebrew/):

``` sh
brew install dpkg
```

To build a package in the project directory, you can run:

``` sh
make package
```

and to automatically install this package on your jailbroken device (over SSH), you can run:

``` sh
make package install THEOS_DEVICE_IP=xxx.xxx.xxx.xxx
```

## License

MyoActivator is available under the MIT license. See the LICENSE file for more info.
