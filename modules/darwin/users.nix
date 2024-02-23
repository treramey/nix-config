{
  username,
  fullname,
  ...
}:
{
  users.users."${username}" = {
    home = "/Users/${username}";
    description = fullname;
  };

  nix.settings.trusted-users = [username];
}
