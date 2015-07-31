{ lib, goPackages, fetchFromGitHub, stdenv, callPackage, strace, git }:

let

  version = "0.8.1";

  uchiwa_src = fetchFromGitHub {
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

    src = uchiwa_src;
  };

  nodePackages = callPackage ../../../top-level/node-packages.nix {
    self = nodePackages;
    generated = ./packages.nix;
  };

in

  stdenv.mkDerivation rec {

    name="uchiwa-0.8.1";

    src = uchiwa_src;

    buildInputs = [ uchiwa_go_package nodePackages.bower strace git ];

    buildPhase = ''
       echo "asdf"
       export HOME=$(pwd)
       bower --allow-root install
       find public
 '';

    installPhase = ''
      mkdir -p $out/bin
      ln -s ${uchiwa_go_package}/bin/uchiwa $out/bin/uchiwa
      ln -s ${uchiwa_go_package}/share $out/share
      cp -a public $out/
'';

    meta = with lib; {
      description = "Uchiwa is a simple dashboard for the Sensu monitoring framework.";
      homepage    = http://uchiwa.io/;
      license     = licenses.mit;
      maintainers = with maintainers; [ theuni ];
      platforms   = platforms.unix;
    };

}
