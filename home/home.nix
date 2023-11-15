{
  inputs,
  pkgs,
  lib,
  ...
}: {

  home = {
    username = "berkano";
    homeDirectory = lib.mkDefault "/home/berkano";
    stateVersion = "22.11";

    packages = with pkgs; [

    ];
  };
}
