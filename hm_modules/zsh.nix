{ config, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    zplug = {
      enable = true;
      plugins = [
        {
          name = "romkatv/powerlevel10k";
          tags = [as:theme depth:1];
        }
      ];
    };

    shellAliases =
      let
        flakeDir = "~/nixos";
      in {
        ls = "ls --color='always'";
        v = "vim";
        rebuild = "sudo nixos-rebuild switch --flake ${flakeDir}#default";
        config = "sudo vim ${flakeDir}/configuration.nix";
        hm = "sudo vim ${flakeDir}/home.nix";
        ff = "fastfetch";
    };

    # p10k Home manager config: https://github.com/nix-community/home-manager/issues/1338#issuecomment-651807792
    initExtraBeforeCompInit = ''
      # p10k instant prompt
      local P10K_INSTANT_PROMPT="${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
    '';

    initExtra = ''
      # Powerlevel10k config
      typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=
      typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
      typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

      if [[ -f $XDG_DATA_HOME/zsh/zshrc ]]; then source $XDG_DATA_HOME/zsh/zshrc; fi

      source $HOME/nixos/hm_modules/p10k
    '';
  };
}
