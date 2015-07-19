{ config, pkgs, lib, ... }:

with pkgs;
with lib;

let

  cfg = config.services.sensu-client;

  client_json = writeText "client.json" ''
    {
      "client": {
        "name": "${config.networking.hostName}",
        "address": "localhost",
        "subscriptions": [ ]
      }
    }
  '';


in {

  options = {

    services.sensu-client = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Enable the Sensu monitoring client daemon.
        '';
      };
      config = mkOption {
        type = types.lines;
        description = ''
          Contents of the sensu client configuration file.
        '';
      };
      extraOpts = mkOption {
        type = with types; listOf str;
        default = [];
        description = ''
          Extra options used when launching sensu.
        '';
      };
    };
  };

  config = mkIf cfg.enable {

    users.extraGroups.sensuclient.gid = config.ids.gids.sensuclient;

    users.extraUsers.sensuclient = {
      description = "sensu client daemon user";
      uid = config.ids.uids.sensuclient;
      group = "sensuclient";
    };

    systemd.services.sensu-client = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.sensu ];
      serviceConfig = {
        User = "sensuclient";
        ExecStart = "${pkgs.sensu}/bin/sensu-client -c ${client_json}";
      };
    };

  };

}
