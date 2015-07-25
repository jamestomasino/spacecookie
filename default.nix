{ mkDerivation, attoparsec, base, bytestring, containers, directory
, filepath, mtl, network, stdenv, text, transformers, unix, yaml
}:
mkDerivation {
  pname = "spacecookie";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  buildDepends = [
    attoparsec base bytestring containers directory filepath mtl
    network text transformers unix yaml
  ];
  description = "gopher server daemon";
  license = stdenv.lib.licenses.gpl3;
}
