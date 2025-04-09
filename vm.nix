{ pkgs, options, config, ... }:
{
  environment.systemPackages = with pkgs; [ kitty pm2 python3 nodejs_20 git bash];

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

  system.stateVersion = "24.11";
}
