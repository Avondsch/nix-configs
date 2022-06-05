# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


 hardware.bluetooth.enable = true;
   networking.hostName = "nixos"; # Define your hostname.
	networking.networkmanager.enable = true;
networking.wireless.iwd.enable = true;
networking.networkmanager.wifi.backend = "iwd";

  # Set your time zone.
   time.timeZone = "Asia/Kolkata";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlan0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
xfce = {
enable = true;
noDesktop = false;
enableXfwm = false;};
};
windowManager.i3.enable = true;
windowManager.bspwm.enable = true;
windowManager.stumpwm.enable = true;
windowManager.dwm.enable = true;
windowManager.herbstluftwm.enable = true;
windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = haskellPackages: [
      haskellPackages.dbus
      haskellPackages.List
      haskellPackages.monad-logger
      haskellPackages.xmonad
    ];
  };
displayManager.defaultSession = "xfce";
displayManager.sddm.enable = true;
  };

 
  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
   hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
   services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.avondsch = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
   };

  # List packages installed in system profile. To search, run:
nixpkgs.config.allowUnfree = true;
   environment.systemPackages = with pkgs; [
     vim 
(st.overrideAttrs (oldAttrs: rec {
    src = fetchFromGitHub {
      owner = "avondsch";
      repo = "terminal";
      rev = "564a04029e67246257824e09e1ea48a0b27d95dd";
      sha256 = "1GPt2xFn8fWkoU/8SqPEmDwMSQt5EKJKksK9EBZmgRc=";
    };
    # Make sure you include whatever dependencies the fork needs to build properly!
    buildInputs = oldAttrs.buildInputs ++ [ harfbuzz ];
  }))
(picom.overrideAttrs(oldAttrs: rec {
          src = fetchFromGitHub {
            repo = "picom";
            owner = "jonaburg";
            rev = "e3c19cd7d1108d114552267f302548c113278d45";
            sha256 = "4voCAYd0fzJHQjJo4x3RoWz5l3JJbRvgIXn1Kg6nz6Y=";
          };
        }))
alacritty
terminus_font
dina-font
nordic
  wget
     firefox
#emacs
emacsPgtkNativeComp
   ];
nixpkgs.overlays = [
  
 (import (builtins.fetchGit {
      url = "https://github.com/nix-community/emacs-overlay.git";
      ref = "master";
      rev = "cd6fbfa22bfd96967231515843fbdef3bda7966f"; # change the revision
    }))

  (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: { src = /home/avondsch/git-repos/yads/src;});
    })
];
services.blueman.enable = true;
services.emacs.package = pkgs.emacsPgtkNativeComp;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

