{
  "amq-protocol" = {
    version = "1.9.2";
    source = {
      type = "gem";
      sha256 = "1gl479j003vixfph5jmdskl20il8816y0flp4msrc8im3b5iiq3r";
    };
  };
  "amqp" = {
    version = "1.5.0";
    source = {
      type = "gem";
      sha256 = "0jlcwyvjz0b28wxdabkyhdqyqp5ji56ckfywsy9mgp0m4wfbrh8c";
    };
    dependencies = [
      "amq-protocol"
      "eventmachine"
    ];
  };
  "async_sinatra" = {
    version = "1.2.0";
    source = {
      type = "gem";
      sha256 = "0sjdvkchq5blvfdahhrlipsx5sr9kfmdx0zxssjlfkz54dbl14m0";
    };
    dependencies = [
      "rack"
      "sinatra"
    ];
  };
  "childprocess" = {
    version = "0.5.6";
    source = {
      type = "gem";
      sha256 = "0j5x5qcl0rg4fxzz83v5f5bj37qmxbiwn92b3mdhk6s63cik76cr";
    };
    dependencies = [
      "ffi"
    ];
  };
  "daemons" = {
    version = "1.2.3";
    source = {
      type = "gem";
      sha256 = "0b839hryy9sg7x3knsa1d6vfiyvn0mlsnhsb6an8zsalyrz1zgqg";
    };
  };
  "em-redis-unified" = {
    version = "1.0.0";
    source = {
      type = "gem";
      sha256 = "0paa2810idjii6z8qdd00jlx3ck5d1w0i3adkbw7x52mpib8iga9";
    };
    dependencies = [
      "eventmachine"
    ];
  };
  "em-worker" = {
    version = "0.0.2";
    source = {
      type = "gem";
      sha256 = "0z4jx9z2q5hxvdvik4yp0ahwfk69qsmdnyp72ln22p3qlkq2z5wk";
    };
    dependencies = [
      "eventmachine"
    ];
  };
  "eventmachine" = {
    version = "1.0.3";
    source = {
      type = "gem";
      sha256 = "09sqlsb6x9ddlgfw5gsw7z0yjg5m2qfjiqkz2fx70zsizj3lqhil";
    };
  };
  "ffi" = {
    version = "1.9.10";
    source = {
      type = "gem";
      sha256 = "1m5mprppw0xcrv2mkim5zsk70v089ajzqiq5hpyb0xg96fcyzyxj";
    };
  };
  "multi_json" = {
    version = "1.11.2";
    source = {
      type = "gem";
      sha256 = "1rf3l4j3i11lybqzgq2jhszq7fh7gpmafjzd14ymp9cjfxqg596r";
    };
  };
  "rack" = {
    version = "1.6.4";
    source = {
      type = "gem";
      sha256 = "09bs295yq6csjnkzj7ncj50i6chfxrhmzg1pk6p0vd2lb9ac8pj5";
    };
  };
  "rack-protection" = {
    version = "1.5.3";
    source = {
      type = "gem";
      sha256 = "0cvb21zz7p9wy23wdav63z5qzfn4nialik22yqp6gihkgfqqrh5r";
    };
    dependencies = [
      "rack"
    ];
  };
  "sensu" = {
    version = "0.20.2";
    source = {
      type = "gem";
      sha256 = "15d46xvwfw4r7l558807xy6c5aq23f5w9wfvhxr5zqrnwvn1lsga";
    };
    dependencies = [
      "async_sinatra"
      "em-redis-unified"
      "eventmachine"
      "multi_json"
      "sensu-em"
      "sensu-extension"
      "sensu-extensions"
      "sensu-logger"
      "sensu-settings"
      "sensu-spawn"
      "sensu-transport"
      "sinatra"
      "thin"
      "uuidtools"
    ];
  };
  "sensu-em" = {
    version = "2.5.2";
    source = {
      type = "gem";
      sha256 = "0khsy2zrfc39qyaqrqlxgik9ia8b78m44xfx8kv5ir5h156bp6bz";
    };
  };
  "sensu-extension" = {
    version = "1.1.2";
    source = {
      type = "gem";
      sha256 = "19qz22fcb3xjz9p5npghlcvxkf8h1rsfws3j988ybnimmmmiqm24";
    };
    dependencies = [
      "sensu-em"
    ];
  };
  "sensu-extensions" = {
    version = "1.2.0";
    source = {
      type = "gem";
      sha256 = "1b8978g1ww7vdrsw7zvba6qvc56s4vfm1hw3szw3j1gsk6j0vb81";
    };
    dependencies = [
      "multi_json"
      "sensu-em"
      "sensu-extension"
      "sensu-logger"
      "sensu-settings"
    ];
  };
  "sensu-logger" = {
    version = "1.0.0";
    source = {
      type = "gem";
      sha256 = "0vwa2b5wa9xqzb9lmhma49171iabwbnnnyhhhaii8n6j4axvar93";
    };
    dependencies = [
      "multi_json"
      "sensu-em"
    ];
  };
  "sensu-settings" = {
    version = "3.1.0";
    source = {
      type = "gem";
      sha256 = "0wri1jhjzxj6ig39ks56s8djzv7ivjk2fmaz8s93kjxv471746pl";
    };
    dependencies = [
      "multi_json"
    ];
  };
  "sensu-spawn" = {
    version = "1.3.0";
    source = {
      type = "gem";
      sha256 = "1vlq8a7qph76ilp4i71wy33sr5h6nwgzddvb3xwx66ylnn4490iv";
    };
    dependencies = [
      "childprocess"
      "em-worker"
      "sensu-em"
    ];
  };
  "sensu-transport" = {
    version = "3.2.0";
    source = {
      type = "gem";
      sha256 = "00njdf9b2x4w15bjrs6mqcnwis7w9hnmrzp02yyqq82fc76n7m8a";
    };
    dependencies = [
      "amqp"
      "em-redis-unified"
      "sensu-em"
    ];
  };
  "sinatra" = {
    version = "1.4.6";
    source = {
      type = "gem";
      sha256 = "1hhmwqc81ram7lfwwziv0z70jh92sj1m7h7s9fr0cn2xq8mmn8l7";
    };
    dependencies = [
      "rack"
      "rack-protection"
      "tilt"
    ];
  };
  "thin" = {
    version = "1.6.3";
    source = {
      type = "gem";
      sha256 = "1m56aygh5rh8ncp3s2gnn8ghn5ibkk0bg6s3clmh1vzaasw2lj4i";
    };
    dependencies = [
      "daemons"
      "eventmachine"
      "rack"
    ];
  };
  "tilt" = {
    version = "2.0.1";
    source = {
      type = "gem";
      sha256 = "1qc1k2r6whnb006m10751dyz3168cq72vj8mgp5m2hpys8n6xp3k";
    };
  };
  "uuidtools" = {
    version = "2.1.5";
    source = {
      type = "gem";
      sha256 = "0zjvq1jrrnzj69ylmz1xcr30skf9ymmvjmdwbvscncd7zkr8av5g";
    };
  };
}
