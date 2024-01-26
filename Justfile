# just is a command runner, Justfile is very similar to Makefile, but simpler.

############################################################################
#
#  Darwin related commands
#
############################################################################

darwin-set-proxy:
  sudo python3 scripts/darwin_set_proxy.py
  sleep 1

darwin: darwin-set-proxy
  nix build .#darwinConfigurations.macos-nix.system \
    --extra-experimental-features 'nix-command flakes'

  ./result/sw/bin/darwin-rebuild switch --flake .#macos-nix

darwin-debug: darwin-set-proxy
  nix build .#darwinConfigurations.macos-nix.system --show-trace --verbose \
    --extra-experimental-features 'nix-command flakes'

  ./result/sw/bin/darwin-rebuild switch --flake .#macos-nix --show-trace --verbose

############################################################################
#
#  nix related commands
#
############################################################################


update:
  nix flake update

history:
  nix profile history --profile /nix/var/nix/profiles/system

gc:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

  # garbage collect all unused nix store entries
  sudo nix store gc --debug


fmt:
  # format the nix files in this repo
  nix fmt

clean:
  rm -rf result
