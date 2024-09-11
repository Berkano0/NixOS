{pkgs, ...}:
with pkgs; [
  firefox
  kate
  unzip
  android-studio
  discord
  distrobox
  tdesktop
  neofetch
  easyeffects
  zoom-us
  zathura
  xclip
  steam
  git
  alacritty
  jetbrains.idea-community
  piper
  heroic
  ranger
  rofi
  fzf
  btop
  xorg.xrandr
  arandr
  eza
  bat
  fd
  zoxide
  onlyoffice-bin
  ripgrep
  pavucontrol
  vesktop
  libnotify
  du-dust
  lazygit
  (pkgs.nerdfonts.override {fonts = ["JetBrainsMono" "Iosevka" "FiraCode"];})
  ffmpeg
  wget
  distrobox
  file
  rofi-wayland
  obsidian
  swww
  grim
  slurp
  wl-clipboard
  alejandra
  nil
  (
    pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    })
  )

  (wineWowPackages.full.override {
    wineRelease = "staging";
    mingwSupport = true;
  })

  stow
  sxhkd
  winetricks
  bottles
]
