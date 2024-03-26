{
  pkgs,
  lib,
  ...
}: {
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
      ];
    };
  };
}