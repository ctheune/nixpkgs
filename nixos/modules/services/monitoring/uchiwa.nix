{ config, pkgs, lib, ... }:

with pkgs;
with lib;

let

  cfg = config.services.uchiwa;

  uchiwa_json = writeText "uchiwa.json" ''
    {
      "sensu": [
        {
          "name": "Local Site",
          "host": "localhost",
          "port": 4567
        }
      ],
      "uchiwa": {
        "host": "0.0.0.0",
        "port": 3000
      }
    }
  '';

in {

  options = {

    services.uchiwa = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Enable the Uchiwa sensu dashboard daemon.
        '';
      };
      config = mkOption {
        type = types.lines;
        description = ''
          Contents of the uchiwa configuration file.
        '';
      };
      extraOpts = mkOption {
        type = with types; listOf str;
        default = [];
        description = ''
          Extra options used when launching uchiwa.
        '';
      };
    };
  };

  config = mkIf cfg.enable {

    users.extraGroups.uchiwa.gid = config.ids.gids.uchiwa;

    users.extraUsers.uchiwa = {
      description = "uchiwa daemon user";
      uid = config.ids.uids.uchiwa;
      group = "uchiwa";
    };

    systemd.services.uchiwa = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.uchiwa ];
      serviceConfig = {
        User = "uchiwa";
        ExecStart = "${pkgs.uchiwa}/bin/uchiwa -c ${uchiwa_json} -p ${pkgs.uchiwa}/public";
      };
    };

  };

}
