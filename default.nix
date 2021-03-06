with import <nixpkgs>{};

let
  qt = qt59;
  gcc = gcc5;
in rec {
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
      qt5.qtbase
      qt5.qtmultimedia
      qt5.qttools
    ];

    gccPkgs = [
      autoconf
      automake
      gcc
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

    QTDIR="${qt.qtbase.dev}";

    MOC="${qt.qtbase.dev}/bin/moc";
    UIC="${qt.qtbase.dev}/bin/uic";
    RCC="${qt.qtbase.dev}/bin/rcc";
    LRELEASE="${qt.qttools.dev}/bin/lrelease";
    LUPDATE="${qt.qttools.dev}/bin/lupdate";

    LD_LIBRARY_PATH = lib.concatStringsSep ":" [
      "src/libbtc/.libs"
      "src/libbtc/src/secp256k1/.libs"
      "src/hidapi/libusb/.libs"
      "src/univalue/.libs"
    ];

    configureFlags = [
      "--enable-debug"
      "--enable-libusb"
      "--with-qt-bindir=${qt.qtbase.dev}/bin:${qt.qttools.dev}/bin"
    ];

    hardeningDisable = [
      "format"
    ];

    README = ''
      Run
        ./autogen.sh
        ./configure --prefix=$PWD/install --enable-debug --enable-libusb
        make
        make install
      in order to produce binaries in $PWD/install.
    '';

    shellHook = ''
      export PS1="\e[1;33m$ \e[0m";
      echo "$README";
      cd tmp;
    '';
  };
}
