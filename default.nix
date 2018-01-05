with import <nixpkgs>{};

rec {
  dbb = stdenv.mkDerivation rec {
    name = "digitalbitbox-dev-env";
    src = ./.;
    version = "0.1.0";

    buildInputs = [
      autoconf
      automake

      boost
      curl
      gcc48
      gcc5
      git
      qt5.qtbase
      qt5.qmake
      qt5.qtmultimedia
      qt5.qttools
      libevent
      libtool
      libudev
      libusb
      libqrencode
      pkgconfig
    ];

    hardeningDisable = [
      "all"
      #"format"
    ];

    shellHook = ''
      export PS1="\e[1;33m$ \e[0m";
      cd src
    '';
  };
}
