{...}: {
  imports = [
    ./core.nix
    ./zsh.nix
    ./zoxide.nix
    ./starship.nix
    ./git/git.nix
    ./git/lazygit.nix
    ./wezterm
  ];
}
