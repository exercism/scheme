{ pkgs ? import <nixpkgs> {}, ... }:
let inherit (pkgs) stdenv fetchgit chez guile;
    chez-srfi = import ./nix/chez-srfi.nix
      { stdenv = stdenv; fetchgit = fetchgit; chez = chez; };
 in pkgs.mkShell { buildInputs = [ chez guile chez-srfi ]; }
