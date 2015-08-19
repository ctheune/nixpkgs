{ lib, goPackages, fetchFromGitHub, stdenv, callPackage, strace, git }:

let

  version = "0.10.3";

  uchiwa_src = fetchFromGitHub {
    owner = "sensu";
    repo = "uchiwa";
    rev = "${version}";
    sha256 = "1zqhr7kxfqz27pvv975szry692ps314spv00r59dvg9caim8mwsh";
  };

  uchiwa_go_package = goPackages.buildGoPackage rec {
    inherit version;

    name = "uchiwa-${version}";
    goPackagePath = "github.com/sensu/uchiwa";

    buildInputs = [
      goPackages.palourde.logger
      goPackages.bencaron.gosensu
      goPackages.dgrijalva.jwt-go
      goPackages.context
      goPackages.mapstructure
    ];

    src = uchiwa_src;
  };

  nodePackages = callPackage ../../../top-level/node-packages.nix {
    self = nodePackages;
    generated = ./packages.nix;
  };

in

  stdenv.mkDerivation rec {

    name="uchiwa-${version}";

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
