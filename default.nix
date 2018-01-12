with import <nixpkgs>{};

rec {
  dbb = stdenv.mkDerivation rec {
    name = "dbb-app.env";
    src = ./.;
    version = "latest";

    buildInputs = [
      curl
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

    LD_LIBRARY_PATH = lib.concatStringsSep ":" [
      "src/libbtc/.libs"
      "src/libbtc/src/secp256k1/.libs"
      "src/hidapi/libusb/.libs"
      "src/univalue/.libs"
    ];

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

      targetPkgs = pkgs: buildInputs;
    };

    shellHook = ''
      export PS1="\e[1;33m$ \e[0m";
      echo "Run"
      echo "  ./autogen.sh"
      echo "  ./configure --prefix=$PWD/install --enable-debug --enable-libusb"
      echo "  make"
      echo "  make install"
      echo "in order to produce binaries in $PWD/install"
      echo ""
      echo "Run \`fhs\` to drop into FHS env from which the install/bin/dbb-app should be executable"
      alias fhs="${fhsEnv}/bin/${name}"
      cd tmp
    '';
  };
}
