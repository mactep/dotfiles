{ pkgs, lib, user, ... }:

{
  # TODO: add git as a dependency. Either import or redefine it.
  programs.bash.shellAliases.dotfiles = "git --git-dir=$HOME/.dotfiles --work-tree=$HOME";
  programs.fish.functions.dotfiles = "git --git-dir=$HOME/.dotfiles --work-tree=$HOME $argv";

  home.activation."dotfiles" = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [[ -v DRY_RUN ]] ; then exit 0 ; fi
    if [ ! -d $HOME/.dotfiles ]; then
        ${pkgs.git}/bin/git clone $VERBOSE_ARG --bare https://github.com/${user.name}/dotfiles.git $HOME/.dotfiles
    fi

    ${pkgs.git}/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no
  '';
}
