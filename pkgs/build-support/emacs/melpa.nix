# builder for Emacs packages built for packages.el
# using MELPA package-build.el

{ lib, stdenv, fetchurl, emacs, texinfo }:

with lib;

{ pname
, version

, files ? null
, fileSpecs ? [ "*.el" "*.el.in" "dir"
                "*.info" "*.texi" "*.texinfo"
                "doc/dir" "doc/*.info" "doc/*.texi" "doc/*.texinfo"
              ]

, meta ? {}

, ...
}@args:

let

  packageBuild = fetchurl {
    url = https://raw.githubusercontent.com/milkypostman/melpa/2b3eb31c077fcaff94b74b757c1ce17650333943/package-build.el;
    sha256 = "1biwg2pqmmdz5iwqbjdszljazqymvgyyjcnc255nr6qz8mhnx67j";
  };

  fname = "${pname}-${version}";

  targets = concatStringsSep " " (if files == null then fileSpecs else files);

  defaultMeta = {
    homepage = args.src.meta.homepage or "http://melpa.org/#/${pname}";
  };

in

import ./generic.nix { inherit lib stdenv emacs texinfo; } ({
  inherit packageBuild;

  buildPhase = ''
    runHook preBuild

    emacs --batch -Q -l $packageBuild -l ${./melpa2nix.el} \
      -f melpa2nix-build-package \
      ${pname} ${version} ${targets}

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    emacs --batch -Q -l $packageBuild -l ${./melpa2nix.el} \
      -f melpa2nix-install-package \
      ${fname}.* $out/share/emacs/site-lisp/elpa

    runHook postInstall
  '';

  meta = defaultMeta // meta;
}

// removeAttrs args [ "files" "fileSpecs"
                      "meta"
                    ])
