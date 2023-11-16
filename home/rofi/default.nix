{
  pkgs,
  config,
  ...
}: {
  xdg.configFile."rofi/config.rasi".source = ./config.rasi;

  home.packages = with pkgs; [rofi-wayland];

  # programs.rofi = {
  #   enable = true;
  #   package = pkgs.rofi-wayland;
  # };
}
