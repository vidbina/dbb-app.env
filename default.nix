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
      gcc49
    ];

    utilPkgs = [
      curl
      file
      git
      less
      strace
      which
    ];

    QTDIR="${qt56.qtbase.dev}";

    MOC="${qt56.qtbase.dev}/bin/moc";
    UIC="${qt56.qtbase.dev}/bin/uic";
    RCC="${qt56.qtbase.dev}/bin/rcc";
    LRELEASE="${qt56.qttools.dev}/bin/lrelease";
    LUPDATE="${qt56.qttools.dev}/bin/lupdate";

    configureFlags = [
      "--enable-debug"
      "--enable-libusb"
      "--with-qt-bindir=${qt56.qtbase.dev}/bin:${qt56.qttools.dev}/bin"
      #"--with-qt-bindir=${QT_BINDDIR}"
    ];

    hardeningDisable = [
      "all"
      #"format"
    ];

    fhsEnv = buildFHSUserEnv {
      inherit name;
    };

    shellHook = ''
      export PS1="\e[1;33m$ \e[0m";
      echo "Type \`fhs\` to drop into FHS env"
      alias fhs="${fhsEnv}/bin/${name}"
      cd tmp
    '';
  };
}
