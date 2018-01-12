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
      gdb
    ];

    utilPkgs = [
      file
      git
      less
      strace
      tree
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
    ];

    hardeningDisable = [
      "format"
    ];

    fhsEnv = buildFHSUserEnv {
      inherit name;

      targetPkgs = pkgs: buildInputs;
    };

    README = ''
      Run
        ./autogen.sh
        ./configure --prefix=$PWD/install --enable-debug --enable-libusb
        make
        make install
      in order to produce binaries in $PWD/install.

      Run "fhs" to drop into a FHS env from which the install/bin/dbb-app should be executable.
    '';

    shellHook = ''
      export PS1="\e[1;33m$ \e[0m";
      echo "$README";
      alias fhs="${fhsEnv}/bin/${name}";
      cd tmp;
    '';
  };
}
