with import <nixpkgs>{};

rec {
  dbb = stdenv.mkDerivation rec {
    name = "digitalbitbox-dev-env";
    src = ./.;
    version = "0.1.0";

    buildInputs = [
      autoconf
      automake

      curl
      gcc48
      libtool
      libudev
      libusb
      pkgconfig
    ];

    hardeningDisable = [
      "format"
    ];

    shellHook = ''
      export PS1="\e[1;33m$ \e[0m";
      cd src
    '';
  };
}
