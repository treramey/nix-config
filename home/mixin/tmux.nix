{pkgs, ...}: let
  palette = {
    lavender = "#b7bdf8";
    base = "#24273a";
    mantle = "#1e2030";
    text = "#cad3f5";
    subtext0 = "#a5adcb";
    red = "#ed8796";
    green = "#a6da95";
    yellow = "#eed49f";
    mauve = "#c6a0f6";
    overlay0 = "#6e738d";
    surface0 = "#363a4f";
    peach = "#f5a97f";
  };
in {
  programs.tmux = {
    enable = true;
    prefix = "C-space";
    keyMode = "vi";
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
    ];

    extraConfig = ''
      # prefix + r  reload configuration
      bind r source-file $XDG_CONFIG_HOME/tmux/tmux.conf \; display-message "Reloaded!"

      set -g renumber-windows on

      # select pane
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # resize pane
      bind -r up resize-pane -U 5
      bind -r down resize-pane -D 5
      bind -r left resize-pane -L 5
      bind -r right resize-pane -R 5

      bind-key -r J swap-pane -D
      bind-key -r K swap-pane -U

      # cycle to next pane
      bind-key -r Tab select-pane -t :.+

      # remap default zoom
      unbind z
      bind Space resize-pane -Z

      # create new windows/panes in same directory
      unbind '"'
      unbind %
      bind c new-window
      bind-key | split-window -hc "#{?pane_path,#{pane_path},#{pane_current_path}}"
      bind-key - split-window -l30% -vc "#{?pane_path,#{pane_path},#{pane_current_path}}"

      bind p previous-window
      bind n next-window

      # display
      set-option -g status "on"
      set-option -g status-style fg=terminal,bg=terminal
      set-option -g status-justify left

      # border
      set -g pane-border-style fg="${palette.surface0}"
      set -g pane-active-border-style fg="${palette.lavender}"

      # messages
      set -g mode-style fg="${palette.mantle}",bg=terminal
      set -g message-style fg="${palette.yellow}",bg=terminal
      set -g message-command-style fg="${palette.yellow}",bg=terminal

      # windows
      set-window-option -g window-style fg="${palette.subtext0}",bg=terminal
      set-window-option -g window-active-style fg="${palette.text}",bg=terminal
      set-window-option -g window-status-style fg="${palette.overlay0}",bg=terminal
      set-window-option -g window-status-separator "#[fg=${palette.green}]"
      set-window-option -g window-status-activity-style fg="${palette.text}",bg=terminal

      # window status
      set-window-option -g window-status-format "#[fg=${palette.base},bg=${palette.overlay0}] #I #[fg=${palette.overlay0},bg=${palette.surface0}] #{b:pane_current_path} "
      set-window-option -g window-status-current-format "#[fg=${palette.base},bg=${palette.peach}] #I #[fg=${palette.peach},bg=${palette.surface0},bold] #{b:pane_current_path} "

      # statusline
      pane_icon=" "
      session_icon=" "
      left_separator=""
      status_text="#[fg=${palette.text},bg=${palette.surface0}]"
      prefix_fg="#{?client_prefix,#[fg=${palette.red}],#[fg=${palette.green}]}"
      prefix_bg="#{?client_prefix,#[bg=${palette.red}],#[bg=${palette.green}]}"

      session_status="$prefix_fg#[bg=${palette.surface0}]$left_separator$prefix_bg#[fg=${palette.base}]$session_icon$status_text #S "
      pane_status="#[fg=${palette.mauve},bg=${palette.surface0}]$left_separator#[fg=${palette.base},bg=${palette.mauve}]$pane_icon$status_text #P-#{window_panes}"

      set -g status-left ""
      set -g status-right "$pane_status $session_status"
    '';
  };
}
