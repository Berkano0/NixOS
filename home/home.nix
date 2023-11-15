{
  inputs,
  pkgs,
  lib,
  ...
}: {

  imports = [./lf.nix];
  home = {
    username = "berkano";
    homeDirectory = lib.mkDefault "/home/berkano";
    stateVersion = "22.11";

    packages = with pkgs; [
		sl
    ];
  };
}
