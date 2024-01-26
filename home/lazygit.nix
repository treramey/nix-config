{...}: let
  palette = {
    text = "#cad3f5";
    red = "#ed8796";
    blue = "#8aadf4";
    lavender = "#b7bdf8";
    yellow = "#eed49f";
    overlay0 = "#6e738d";
    surface0 = "#363a4f";
    surface1 = "#494d64";
  };
in {
  xdg.enable = true;

  programs.lazygit = {
    enable = true;

    settings = {
      gui = {
        theme = {
          activeBorderColor = ["${palette.lavender}" "bold"];
          inactiveBorderColor = ["${palette.overlay0}"];
          searchingActiveBorderColor = ["${palette.yellow}"];
          optionsTextColor = ["${palette.blue}"];
          selectedLineBgColor = ["${palette.surface0}"];
          cherryPickedCommitBgColor = ["${palette.surface1}"];
          cherryPickedCommitFgColor = ["${palette.lavender}"];
          unstagedChangesColor = ["${palette.red}"];
          defaultFgColor = ["${palette.text}"];
        };
        border = "rounded";
      };
    };
  };
}
