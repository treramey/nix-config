{...}: let
  term = "xterm-256color";
in {
  programs.alacritty = {
    enable = true;

    settings = {
      env = {
        TERM = "${term}";
      };

      window = {
        blur = true;
        opacity = 0.72;
        decorations = "Buttonless";
        option_as_alt = "OnlyLeft";
        dimensions = {
          lines = 42;
          columns = 138;
        };
      };

      font = {
        size = 16;
        normal = {
          family = "Input Nerd Font";
        };
        bold_italic = {
          family = "InputIta Nerd Font";
        };
      };

      selection = {
        save_to_clipboard = true;
      };

      cursor = {
        style = {
          shape = "Beam";
        };
      };

      mouse = {
        hide_when_typing = true;
      };
    };
  };
}
