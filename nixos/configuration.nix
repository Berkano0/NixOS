{ config, pkgs, system, ... }:
let 

	mypkgs = import ./pkgs.nix {inherit pkgs;};

in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.


  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Kyiv";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  services.xserver.enable = true;

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  

  services.xserver = {
  	videoDrivers = ["nvidia"];

windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];

    };
    layout = "us,ru";
    xkbVariant = "";
    xkbOptions = "grp:win_space_toggle";
  };


  	services.printing.enable = false;
	services.flatpak.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };


hardware = { 
	nvidia = {
		package = config.boot.kernelPackages.nvidiaPackages.stable;
		modesetting.enable = true;
	};	
	opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
    		};
};


programs.noisetorch.enable = true;
programs.zsh.enable = true;
programs.hyprland.enable = true;
programs.hyprland.nvidiaPatches = true;
  users.users.berkano = {
    isNormalUser = true;
    description = "berkano";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = mypkgs;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  ];

environment.sessionVariables = {
	WLR_NO_HARDWARE_CURSORS="1";
};

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;

  system.stateVersion = "23.05"; # Did you read the comment?

}
