{pkgs, ...}:

{
	home.file.".config/sxhkd/sxhkdrc".text = ''
	
Menu 
	rofi -show drun 

	'';
}
