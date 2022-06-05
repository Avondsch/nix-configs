{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "avondsch";
  home.homeDirectory = "/home/avondsch";

home.packages = [                               
pkgs.discord
pkgs.discocss
pkgs.nodejs
pkgs.ffmpeg
pkgs.sxhkd
pkgs.eww
pkgs.gnome.nautilus
pkgs.git
pkgs.lxappearance
pkgs.nitrogen
pkgs.polybar
pkgs.rofi
pkgs.tint2
pkgs.neofetch  
pkgs.htop
# stuff for emacs.
pkgs.tabnine
pkgs.tree-sitter
pkgs.rnix-lsp
pkgs.jdt-language-server
pkgs.elixir_ls
pkgs.erlang-ls

 ];


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
