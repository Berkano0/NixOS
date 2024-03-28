{pkgs, ...}: {
  programs.zsh = {
    enable = true;
  };
  programs.zsh.initExtra = ''
          autoload -U colors && colors
          PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
          #alias update="sudo nixos-rebuild switch --flake ~/Config#nixos"
          alias enix="nvim ~/Config/nixos/configuration.nix"
          update()
          {
          	pushd ~/Config
          	git add -A
          	git commit -m "$(date)"
          	sudo nixos-rebuild switch --flake ~/Config#nixos
          	popd
          }
          alias epkgs="nvim ~/Config/nixos/pkgs.nix"

          EDITOR="nvim"

       hst() {
              history 0 | cut -c 8- | uniq | ${pkgs.fzf}/bin/fzf | ${pkgs.wl-clipboard}/bin/wl-copy
          }

    lfcd () {
             tmp="$(mktemp)"
             lf -last-dir-path="$tmp" "$@"
             #./lfrun
             if [ -f "$tmp" ]; then
                 dir="$(cat "$tmp")"
                 rm -f "$tmp"
                 if [ -d "$dir" ]; then
                     if [ "$dir" != "$(pwd)" ]; then
                         cd "$dir"
                     fi
                 fi
             fi
         }
         alias lf="lfcd"

  '';
}
