{pkgs, ...}: {
  home.packages = with pkgs; [
    # archives
    zip
    xz
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    fzf # A command-line fuzzy finder
  ];
}
