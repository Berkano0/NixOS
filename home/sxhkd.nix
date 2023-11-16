{pkgs, ...}:

{
	home.configFile."sxhkd/sxhkdrc".text = ''
	
		Menu 
			rofi -show drun 

	'';
}
