
{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "pecunia";
  home.homeDirectory = "/home/pecunia";

  nixpkgs.config = {
    allowUnfree = true;
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    fastfetch
    virt-manager
    looking-glass-client
    vscode
    spotify
    (pkgs.discord.override {
      withVencord = true;
    })
  ];

  programs.alacritty = {
	enable = true;
  };
  
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
    shellAliases = {
      ll = "ls -l";
      lag = "ls -ag";
      ls = "ls --color='always'";
      grep = "grep --color='always'";
      "..." = "../..";
    };

    # p10k Home manager config: https://github.com/nix-community/home-manager/issues/1338#issuecomment-651807792
    initExtraBeforeCompInit = ''
      # p10k instant prompt
      local P10K_INSTANT_PROMPT="${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"

      # Custom completions
      # TODO: get rid of it?
      fpath+=("$XDG_DATA_HOME/zsh/completions")

      # correction
    '';

    initExtra = ''
      # Powerlevel10k config
      typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=
      typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
      typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

      if [[ -f $XDG_DATA_HOME/zsh/zshrc ]]; then source $XDG_DATA_HOME/zsh/zshrc; fi

      # other nice things
      bindkey "^[[3~" delete-char
      bindkey "^[[H" beginning-of-line
      bindkey "^[[F" end-of-line
      bindkey "^[[1;5D" backward-word
      bindkey "^[[1;5C" forward-word
      source $HOME/nixos/configs/p10k
    '';
  };
  
  # configure virt-manager
  dconf.settings = {
	"org/virt-manager/virt-manager/connections" = {
		autoconnect = ["qemu:///system"];
		uris = ["qemu:///system"];
	};
  };

  programs.git = {
	enable = true;
	userName = "Laurie";
	userEmail = "laurie201@protonmail.ch";
	extraConfig = {
	init.defaultBranch = "main";
	};
  };
  
  programs.bash = {
	enable = true;
  };
  
  programs.direnv = {
	enable = true;
	enableBashIntegration = true;
        nix-direnv.enable = true;
  };
  
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/root/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
