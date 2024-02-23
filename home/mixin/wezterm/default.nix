{...}: {
  programs.wezterm = {
    enable = false;
    enableZshIntegration = true;
  };
  xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
}
