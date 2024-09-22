
{ config, pkgs, ... }:

{
  home.username = "pecunia";
  home.homeDirectory = "/home/pecunia";

  nixpkgs.config = {
    allowUnfree = true;
  };

  imports = [
    ./hm_modules/zsh.nix
  ];
  
  # Home manager
  home.stateVersion = "24.05";

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
  
  # for dev environments
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
