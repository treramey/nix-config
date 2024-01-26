{pkgs, ...}: {
  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    neovim
    git
    just
  ];

  environment.variables.EDITOR = "nvim";

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      # cleanup = "zap";
    };

    # masApps = {
    #   Xcode = 497799835;
    # };

    taps = [
      "homebrew/cask-fonts"
      "homebrew/services"
      "homebrew/cask-versions"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "curl"
      "fd"
      "fzf"
      "lua"
      "ripgrep"
      "wget"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      # "docker"
    ];
  };
}
