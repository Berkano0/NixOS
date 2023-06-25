{
  description = "Your new nix config";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-alien.url = "github:thiagokokada/nix-alien";
  };

  outputs = { nixpkgs, home-manager, nix-alien, nix-index-database, ... }@inputs:
    let
      username = "berkano";
      hostname = "nixos";
      system = "x86_64-linux";
      stateVersion = "23.05";

      homeDirPrefix = if pkgs.stdenv.hostPlatform.isDarwin then "/Users" else "/home";
      homeDirectory = "/${homeDirPrefix}/${username}";

      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };

      # home = (import ./home-manager/home.nix {
      #   inherit homeDirectory pkgs stateVersion system username inputs;
      # });
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {

          specialArgs = { inherit inputs system; };
          modules = [ 
            ./nixos/configuration.nix
          ];

        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      # homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      #   extraSpecialArgs = { inherit inputs; };
      #
      #   modules = [
      #     home
      #     nix-index-database.hmModules.nix-index
      #   ];
      # };
    };
}
