{ config, pkgs, lib, ... }:

with pkgs;
with lib;

let

  cfg = config.services.sensu-server;

  urls = [
"www.google.com"
"www.gocept.com"
"flyingcircus.io"
"portal.staralliance.com"
"karl.soros.org"
];

  http_checks = lib.concatStringsSep ",\n" (map (x: ''
    "check_${x}": {
      "notification": "${x} HTTP failed",
      "command": "check_http ${x}",
      "subscribers": ["default"],
      "interval": 60,
      "handlers": []
    }
'') urls);

  sensu_server_json = pkgs.writeText "sensu-server.json"
    ''
    {
      "checks": {
        ${http_checks}
      },

   "handlers": {
    "email": {
      "type": "pipe",
      "command": "mail -s 'sensu alert' christian@theune.cc"
    },
    "default": {
      "handlers": [
        "email"
      ],
      "type": "set"
    }
  }

    ${config.services.sensu-server.config}

    }

    '';

in {

  options = {

    services.sensu-server = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Enable the Sensu monitoring server daemon.
        '';
      };
      config = mkOption {
        type = types.lines;
        description = ''
          Contents of the sensu configuration file.
        '';
        default = "";
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

    users.extraGroups.sensuserver.gid = config.ids.gids.sensuserver;

    users.extraUsers.sensuserver = {
      description = "sensu server daemon user";
      uid = config.ids.uids.sensuserver;
      group = "sensuserver";
    };

    services.rabbitmq.enable = true;
    services.redis.enable = true;
    services.postfix.enable = true;

    systemd.services.sensu-server = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.sensu pkgs.bash pkgs.mailutils ];
      serviceConfig = {
        User = "sensuserver";
        ExecStart = "${pkgs.sensu}/bin/sensu-server -v -c ${sensu_server_json}";
        Restart = "always";
        RestartSec = "5s";
      };
      };

  };

}
