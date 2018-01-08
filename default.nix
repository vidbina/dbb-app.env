with import <nixpkgs>{};

rec {
  dbb = stdenv.mkDerivation rec {
    name = "digitalbitbox-dev-env";
    src = ./.;
    version = "0.1.0";

    buildInputs = [
      boost
      libevent
      libtool
      libudev
      libusb
      libqrencode
      pkgconfig
    ] ++ gccPkgs ++ utilPkgs ++ qtPkgs;

    qtPkgs = [
      #qt5.full
      qt56.full
#      qt5.qtbase
#      qt5.qmake
#      qt5.qtmultimedia
#      qt5.qttools
    ];

    gccPkgs = [
      autoconf
      automake
    ];

    utilPkgs = [
      curl
      #gcc48
      gcc5
      gcc6
      git
      less
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
