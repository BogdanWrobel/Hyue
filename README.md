# Hyue
Philips Hue controller for Garmin watches.

Unfortunately, works only in emulator due to SSL restrictions and invalid bridge certificate. Just uncheck _Settings - Use Device HTTPS Requirements_.

The bridge IP and user token are currently hard-coded; adding device discovery and authentication should be easy enough for anyone interested. Just change the values defined in _HyueComms.mc_ file.

_HyueComms_ is a class, since it is not possible to have a method without a class.
