{
  description = "A very basic flake";

  inputs.athame.url = "github:ardagnir/athame/v1.2";
  inputs.athame.flake = false;
  inputs.vimbed.url = "github:ardagnir/vimbed/master";
  inputs.vimbed.flake = false;

  inputs.flake-utils.url = "github:numtide/flake-utils/master";

  outputs = { self, nixpkgs, athame, vimbed, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
  let pkgs = nixpkgs.legacyPackages.${system}; in
    rec {
      defaultPackage = pkgs.callPackage ./zsh-athame.nix { inherit athame vimbed; };
    }
  );
}
