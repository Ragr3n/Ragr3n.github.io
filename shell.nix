let

  # See https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs for more information on pinning
  nixpkgs = builtins.fetchTarball {
    # Descriptive name to make the store path easier to identify
    name = "nixpkgs-23-11";
    # Commit hash for nixos-unstable as of 2019-02-26
    url = https://github.com/NixOS/nixpkgs/archive/refs/heads/nixos-23.11.zip;
    # Hash obtained using `nix-prefetch-url --unpack <url>`
    sha256 = "sha256:1f5d2g1p6nfwycpmrnnmc2xmcszp804adp16knjvdkj8nz36y1fg";
  };
in

{ pkgs ? import nixpkgs {} }:

with pkgs;

pkgs.mkShell {
  packages = [
    python311Packages.mkdocs-material
  ];
}