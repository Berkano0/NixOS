{
  pkgs,
  config,
  lib,
  ...
}: {
  # xdg.configFile."lf/icons".source = ./icons;

  programs.lf = {
    enable = true;
    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
        ''${{
            printf "Directory Name: "
                read DIR
                mkdir $DIR
        }}
      '';

      # on-cd = ''
      #   ''${{
      #       notify-send "$(pwd)"
      #       ls -a | grep '\.meta$'
      #   }}
      # '';
    };
    keybindings = {
      "\\\"" = "";
      o = "";
      d = "";
      e = "";
      f = "";
      c = "mkdir";
      "." = "set hidden!";
      D = "delete";
      p = "paste";
      dd = "cut";
      y = "copy";
      "`" = "mark-load";
      "\\'" = "mark-load";
      "<enter>" = "open";
      a = "rename";
      r = "reload";
      C = "clear";
      U = "unselect";

      do = "dragon-out";

      "g~" = "cd";
      gh = "cd";
      "g/" = "/";
      gD = "cd ~/Downloads";
      gv = "cd ~/Videos";
      go = "cd ~/Documents";
      gc = "cd ~/.config";
      gC = "cd ~/Config";
      gp = "cd ~/Projects";
      gS = "cd ~/.local/share";
      gm = "cd /run/media";

      ee = "editor-open";
      V = ''''$${pkgs.bat}/bin/bat --paging=always --theme=gruvbox "$f"'';
    };

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    extraConfig = let
      previewer = pkgs.writeShellScriptBin "pv.sh" ''
        file=$1
        w=$2
        h=$3
        x=$4
        y=$5

        if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
            ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
                exit 1
                fi

                ${pkgs.pistol}/bin/pistol "$file"
      '';
      cleaner = pkgs.writeShellScriptBin "clean.sh" ''
        ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
      '';
    in ''
      set cleaner ${pkgs.ctpv}/bin/ctpvclear
      set previewer ${pkgs.ctpv}/bin/ctpv
      cmd stripspace %stripspace "$f"

      on-cd
    '';
  };
}
