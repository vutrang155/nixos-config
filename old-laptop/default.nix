{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  users.users.vu = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "incus-admin"
    ];
    packages = with pkgs; [
      tree
      git
    ];

    openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDXD4WjEgEw4oDoPj2s3sV3SXuBNEzZaK+htmVW6d7wH tranghoangphongvu@gmail.com"
    ];
  };

  time.timeZone = "Europe/Paris";

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  # Networking stuffs
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
    };
  };

  networking = {
    hostName = "home-server";
    networkmanager.enable = true;
    firewall.enable = true;
    firewall.allowedTCPPorts = [
      22 # SSH
      8445 # Incus
      8080 # Marathon dashboard
    ];
  };

  # Closed lid stuffs
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Incus
  networking.nftables.enable = true;
  virtualisation.incus.enable = true;
  virtualisation.incus.ui.enable = true;

  security.sudo.wheelNeedsPassword = true;
  system.stateVersion = "25.11";
}
