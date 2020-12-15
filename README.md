# Hyue
Philips Hue controller for Garmin watches.

Unfortunately, works only in emulator due to SSL restrictions and invalid bridge certificate. Just uncheck _Settings - Use Device HTTPS Requirements_.

The bridge IP and user token are currently hard-coded; adding device discovery and authentication should be easy enough for anyone interested. Just change the values defined in _HyueComms.mc_ file.

_HyueComms_ is a class, since it is not possible to have a method without a class.

![hyue0](https://user-images.githubusercontent.com/2101927/102256582-da9f5f80-3f0b-11eb-8273-192ce306c6cd.png) ![hyue1](https://user-images.githubusercontent.com/2101927/102256587-dbd08c80-3f0b-11eb-8f72-11c0ca5b6e73.png)
