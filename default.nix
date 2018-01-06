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

      which
    ];

    QTDIR="${qt5.qtbase.dev}";
    MOC="${qt5.qtbase.dev}/bin/moc";
    UIC="${qt5.qtbase.dev}/bin/uic";
    RCC="${qt5.qtbase.dev}/bin/rcc";
    LRELEASE="${qt5.qttools.dev}/bin/lrelease";
    LUPDATE="${qt5.qttools.dev}/bin/lupdate";

    QTBASE="${qt5.qtbase.bin}";
    QTBASE_DEV="${qt5.qtbase.dev}";
    QTTOOLS="${qt5.qttools.bin}";
    QTTOOLS_DEV="${qt5.qttools.dev}";

    configureFlags = [
      "--enable-debug"
      "--enable-libusb"
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
