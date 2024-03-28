{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./lf.nix
    ./rofi
    ./sxhkd.nix
    ./hypr.nix
    ./zsh.nix
	./kitty.nix
	./gtk.nix
	./mako.nix
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.kanagawa;

  services.mako.enable = true;
  home = {
    username = "berkano";
    homeDirectory = lib.mkDefault "/home/berkano";
    stateVersion = "22.11";

    packages = with pkgs; [
      sl
    ];
  };
  nix.settings.use-xdg-base-directories = true;
}
