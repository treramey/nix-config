{pkgs, ...}: {
  home.packages = with pkgs; [
    # archives
    zip
    xz
    unzip

    # utils
    fd
    fzf
    ripgrep

    just
  ];
}
