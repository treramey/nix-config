{username, fullname, ...}: let
  hostname = "macos-nix";
in {
  users.users."${username}" = {
    home = "/Users/${username}";
    description = fullname;
  };

  nix.settings.trusted-users = [username];
}
