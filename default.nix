with import <nixpkgs>{};

rec {
  dbb = stdenv.mkDerivation rec {
    name = "digitalbitbox-dev-env";
    src = ./.;
    version = "0.1.0";

    #libudev_LIBS="${libudev.out}/lib";
    #libudev_LIBS="${libudev.lib}";

    #libudev_SRC="${libudev.out}/src";

    udev = libudev;

    buildInputs = [
      autoconf
      automake

      curl
      libtool
      libudev
      libusb
      pkgconfig
    ];
  };
}
