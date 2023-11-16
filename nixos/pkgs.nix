{pkgs, ...}:

with pkgs; [
	
	firefox
	kate
	discord
	tdesktop
	neofetch
	easyeffects
	xclip
	steam
	git
	alacritty
	piper
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
	vesktop
	du-dust
	lazygit
	ffmpeg
	wget
	file
	rofi-wayland
	obsidian
	swww
	grim
    	slurp
    	wl-clipboard
	picom-jonaburg
	
	(pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
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
