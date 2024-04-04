{pkgs, ...}: {
  programs.zsh = {
    enable = true;
  };
  programs.zsh.initExtra = ''
           autoload -U colors && colors
           PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
           #alias update="sudo nixos-rebuild switch --flake ~/.config/NixOS#nixos"
           alias enix="nvim ~/.config/NixOS/nixos/configuration.nix"
           update()
           {
           	pushd ~/.config/NixOS
           	git add -A
           	git commit -m "$(date)"
    git push
           	sudo nixos-rebuild switch --flake ~/.config/NixOS#nixos
           	popd
           }
           alias epkgs="nvim ~/.config/NixOS/nixos/pkgs.nix"

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
    alias ndz="nix develop --impure -c zsh"


    [ -f "$HOME/.local/share/zsh/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ] && \
    source "$HOME/.local/share/zsh/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
  '';
  home.file.".local.share/zsh/zsh-fast-syntax-highlighting".source = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
}
