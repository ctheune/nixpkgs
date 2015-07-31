{ config, pkgs, lib, ... }:

with pkgs;
with lib;

let

  cfg = config.services.sensu-api;

in {

  options = {

    services.sensu-api = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Enable the Sensu monitoring API daemon.
        '';
      };
      config = mkOption {
        type = types.lines;
        description = ''
          Contents of the sensu API configuration file.
        '';
      };
      extraOpts = mkOption {
        type = with types; listOf str;
        default = [];
        description = ''
          Extra options used when launching sensu API.
        '';
      };
    };
  };

  config = mkIf cfg.enable {

    users.extraGroups.sensuapi.gid = config.ids.gids.sensuapi;

    users.extraUsers.sensuapi = {
      description = "sensu api daemon user";
      uid = config.ids.uids.sensuapi;
      group = "sensuapi";
    };

    services.rabbitmq.enable = true;
    services.redis.enable = true;

    systemd.services.sensu-api = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.sensu ];
      serviceConfig = {
        User = "sensuapi";
        ExecStart = "${pkgs.sensu}/bin/sensu-api";
        Restart = "always";
        RestartSec = "5s";
      };
    };

  };

}
