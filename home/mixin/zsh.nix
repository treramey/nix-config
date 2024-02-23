{pkgs, ...}: {
  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";

    enableCompletion = true;

    completionInit = ''
      autoload -Uz compinit && compinit

      setopt LIST_PACKED
      setopt ALWAYS_TO_END

      # Enable keyboard navigation of completions in menu
      # (not just tab/shift-tab but cursor keys as well):
      zstyle ':completion:*' menu select
      zmodload zsh/complist

      # use the vi navigation keys in menu completion
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history

      # persistent reshahing i.e puts new executables in the $path
      # if no command is set typing in a line will cd by default
      zstyle ':completion:*:commands' rehash 1

      # Categorize completion suggestions with headings:
      zstyle ':completion:*' group-name '''
      # Style the group names
      zstyle ':completion:*' format %F{cyan}%{$'\e[3m'%}%{$'\e[2m'%}--- %d ---%{$'\e[22m'%}%{$'\e[23m'%}%f

      # Added by running `compinstall`
      zstyle ':completion:*' expand suffix
      zstyle ':completion:*' file-sort modification
      zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ':completion:*' list-suffixes true
      # End of lines added by compinstall

      # Cache
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
    '';

    history = {
      path = "$XDG_CACHE_HOME/zsh/zsh_history";
      expireDuplicatesFirst = true;
    };

    shellAliases = {
      ls = "ls --color=auto";
      l = "ls -lAFh";
      la = "ls -lAFh";
      lr = "ls -tRFh";
      lt = "ls -ltFh";
      ll = "ls -l";
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "pattern" "cursor"];
      styles = {
        path = "fg=#cba6f7";
        alias = "fg=#94e2d5,bold";
      };
    };

    # Extra commands that should be added to {file}`.zshenv`
    envExtra = ''
      export XDG_CONFIG_HOME="$HOME/.config"
      export XDG_DATA_HOME="$HOME/.local/share"
      export XDG_CACHE_HOME="$HOME/.cache"
      export ESLINT_USE_FLAT_CONFIG=true
    '';
  };
}
