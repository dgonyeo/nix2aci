{ mkACI, pkgs, thin ? false, ... } @ args:
let
  pkg = pkgs.go15Packages.etcd.bin;
in

mkACI rec {
  inherit pkgs;
  inherit thin;

  acName = "etcd";
  acVersion = builtins.elemAt (pkgs.stdenv.lib.strings.splitString "v" pkg.name) 1;

  packages = [ pkg ];
  exec = "/bin/etcd";

  mounts = {
    datadir = "/var/db/etcd2";
  };

  mountsRo = {
    resolvconf = "/etc/resolv.conf";
  };

  env = {
    ETCD_DATA_DIR = "/var/db/etcd2/";
  };
}
