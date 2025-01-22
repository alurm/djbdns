{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system: let
    pkgs = inputs.nixpkgs.legacyPackages.${system};
  in {
    packages.default = let
      fefe = pkgs.fetchurl {
        url = "https://www.fefe.de/dns/djbdns-1.05-test32.diff.xz";
        hash = "sha256-Wr8Dh6jiPcJ7up9XU/Ev1wEzV5mhXl5SlVbElW6lpiA=";
      };
    in
      pkgs.djbdns.overrideAttrs (old: {
        patches = [
          ./nixpkgs.patch
          fefe
        ];
      });
  });
}
