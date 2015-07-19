{ lib, goPackages, fetchFromGitHub, stdenv, callPackage }:

let

  version = "0.8.1";
  src = fetchFromGitHub {
    owner = "sensu";
    repo = "uchiwa";
    rev = "${version}";
    sha256 = "0v33dci0lawqxkzr8nzpa92mv6i5ylcb1d5y5iq41sw6w3x21a1q";
  };
  uchiwa_go_package = goPackages.buildGoPackage rec {
    inherit version;

    name = "uchiwa-${version}";
    goPackagePath = "github.com/sensu/uchiwa";

    buildInputs = [
      goPackages.palourde.logger
      goPackages.bencaron.gosensu
      goPackages.dgrijalva.jwt-go
    ];

    inherit src;
  };
  nodePackages =  callPackage (import ../../../top-level/node-packages.nix) {
    self = nodePackages;
    generated = ./packages.nix;
  };

in

  stdenv.mkDerivation {

    name="uchiwa-0.8.1";

    src = src;

    buildInputs = [ uchiwa_go_package  ];

    buildPhase = ''
       bower --allow-root install
 '';

    installPhase = ''
      mkdir -p $out/bin
      ln -s ${uchiwa_go_package}/bin/uchiwa $out/bin/uchiwa
      ln -s ${uchiwa_go_package}/share $out/share
'';

    meta = with lib; {
      description = "Uchiwa is a simple dashboard for the Sensu monitoring framework.";
      homepage    = http://uchiwa.io/;
      license     = licenses.mit;
      maintainers = with maintainers; [ theuni ];
      platforms   = platforms.unix;
    };

}
