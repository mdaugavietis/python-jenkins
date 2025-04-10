{ pkgs, options, config, ... }:
{
  environment.systemPackages = with pkgs; [ kitty pm2 python3 nodejs_20 git bash htop ];

  services.jenkins = {
    enable = true;
    packages =
      options.services.jenkins.packages.default
      ++ config.environment.systemPackages;
  };

  programs = {
    npm.enable = true;
    git.enable = true;
  };

  virtualisation = {
    forwardPorts = [
      { from = "host"; host.port = 8080; guest.port = 8080; }
      { from = "host"; host.port = 7001; guest.port = 7001; }
      { from = "host"; host.port = 7002; guest.port = 7002; }
      { from = "host"; host.port = 7003; guest.port = 7003; }
      { from = "host"; host.port = 7004; guest.port = 7004; }
    ];
    diskSize = 3 * 1024;
    cores = 3;
    memorySize = 4 * 1024;
  };

  system.stateVersion = "24.11";
}
