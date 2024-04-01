{config, ...}: {
  programs.zathura = {
    enable = true;
    options = with config.colorScheme.colors; {
      default-bg = "#${base00}";
      default-fg = "#${base06}";

      statusbar-fg = "#${base02}";
      statusbar-bg = "#${base01}";

      inputbar-bg = "#${base00}";
      inputbar-fg = "#${base06}";

      notification-bg = "#${base00}";
      notification-fg = "#${base06}";

      notification-error-bg = "#${base00}";
      notification-error-fg = "#${base08}";

      notification-warning-bg = "#${base00}";
      notification-warning-fg = "#${base08}";

      highlight-color = "#${base0A}";
      highlight-active-color = "#${base0D}";

      completion-bg = "#${base03}";
      completion-fg = "#${base0D}";

      completion-highlight-fg = "#${base06}";
      completion-highlight-bg = "#${base0D}";

      recolor-lightcolor = "#${base00}";
      recolor-darkcolor = "#${base06}";

      recolor = "false";
      recolor-keephue = "false";
    };
  };

  home.file.".config/zathura/penis".text = "xui";
}
