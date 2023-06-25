{pkgs, ...}:

with pkgs; [
	
	firefox
	kate
	discord
	tdesktop
	neofetch
	easyeffects
	xclip
	git
	alacritty
	ranger
	rofi
	fzf
	btop
	exa
	bat
	fd
	zoxide
	ripgrep
	du-dust
	lazygit
	ffmpeg
	wget
	file
	
	(wineWowPackages.full.override {
     	wineRelease = "staging";
     	mingwSupport = true;
   	})
	
	winetricks
	bottles
]
