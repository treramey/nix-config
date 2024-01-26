{...}: {
  programs.starship = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      character = {
        success_symbol = "[󱢺](bold green)";
        error_symbol = "[󰚌](bold red)";
        vicmd_symbol = "[](bold green)";
      };
      lua = {
        symbol = " ";
        style = "#51a0cf";
      };
      python = {
        symbol = " ";
        style = "#ffbc03";
      };

      golang = {
        symbol = " ";
        style = "#519aba";
      };

      rust = {
        symbol = " ";
        style = "#dea584";
      };

      nodejs = {
        symbol = "󰎙 ";
        style = "#5fa04e";
        detect_files = ["package.json"];
      };

      package = {
        disabled = true;
      };
    };
  };
}
