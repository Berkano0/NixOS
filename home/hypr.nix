{
  pkgs,
  lib,
  ...
}: let
  startScript = pkgs.writeShellScriptBin "start" ''
     ${pkgs.swww}/bin/swww init &

     ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &

     hyprctl setcursor Bibata-Modern-Ice 16 &

     # wait a tiny bit for wallpaper
     sleep 2


    ${pkgs.telegram-desktop}/bin/telegram-desktop &
    ${pkgs.vesktop}/bin/vesktop &
    ${pkgs.firefox}/bin/firefox &

  '';
in {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      bind =
        [
          "$mainMod, return, exec, ${pkgs.kitty}/bin/kitty"
          "$mainMod, C, killactive,"
          "$mainMod SHIFT, M, exit,"
          "$mainMod SHIFT, F, togglefloating,"
          "$mainMod, F, fullscreen,"
          # "$mainMod, G, togglegroup,"
          # "$mainMod, bracketleft, changegroupactive, b"
          # "$mainMod, bracketright, changegroupactive, f"
          # "$mainMod, O, exec, wofi --show drun"
          "$mainMod, S, exec, rofi -show drun -show-icons"
          # "$mainMod, P, pin, active"

          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          "$mainMod SHIFT, left, movewindow, l"
          "$mainMod SHIFT, right, movewindow, r"
          "$mainMod SHIFT, up, movewindow, u"
          "$mainMod SHIFT, down, movewindow, d"
          '', KP_Subtract, exec, amixer sset Capture toggle && amixer get Capture | grep "\[off\]" && (notify-send "MIC switched OFF")  || (notify-send "MIC switched ON")''
		  '', Print, exec, ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.imagemagick}/bin/convert - -shave 1x1 PNG:- | ${pkgs.wl-clipboard}/bin/wl-copy''
		  ''$mainMod, E, exec, ${pkgs.wl-clipboard}/bin/wl-paste | ${pkgs.swappy}/bin/swappy -f -''
		  # '', Alt_L, kb_layout = "ua"''
          # "$mainMod, h, movefocus, l"
          #         	"$mainMod, l, movefocus, r"
          #         	"$mainMod, k, movefocus, u"
          #         	"$mainMod, j, movefocus, d"
          #
          #         	"$mainMod SHIFT, h, movewindow, l"
          #         	"$mainMod SHIFT, l, movewindow, r"
          #         	"$mainMod SHIFT, k, movewindow, u"
          #         	"$mainMod SHIFT, j, movewindow, d"

          # Scroll through existing workspaces with mainMod + scroll
        ]
        ++ map (n: "$mainMod SHIFT, ${toString n}, movetoworkspace, ${toString (
          if n == 0
          then 10
          else n
        )}") [1 2 3 4 5 6 7 8 9 0]
        ++ map (n: "$mainMod, ${toString n}, workspace, ${toString (
          if n == 0
          then 10
          else n
        )}") [1 2 3 4 5 6 7 8 9 0];

      input = {
        kb_layout = "us,ru,ua";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:alt_shift_toggle,caps:escape";

        kb_rules = "";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = false;
        };

        repeat_rate = 40;
        repeat_delay = 250;
        force_no_accel = true;

        sensitivity = 0.0; # -1.0 - 1.0, 0 means no modification.
      };

      exec-once = [
        "${pkgs.wl-gammactl}/bin/wl-gammactl -c 1.025 -b 1.050 -g 1.000"
        "waybar"
		"${pkgs.bash}/bin/bash ${startScript}/bin/start"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 5;

        drop_shadow = true;
        shadow_range = 30;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(252fbaff) rgba(252fbaff) 60deg";
        "col.inactive_border" = "rgba(303140ff)";

        layout = "master";
      };
    };
  };
}
