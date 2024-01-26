{mvim, ...}: 
{
  xdg.configFile = {
    "nvim" = {
      source = mvim;
      force = true;
    };
  };
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
