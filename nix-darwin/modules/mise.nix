{ config, pkgs, ... }:

{
  programs.mise = {
    enable = true;
    enableZshIntegration = true;

    globalConfig = {
      tools = {
        dart = ["latest"];
        flutter = ["latest"];
        go = ["1.23"];
        kotlin = ["latest"];
        node = ["lts"];
        python = ["3.13"];
        ruby = ["3.3.6"];
        rust = ["latest"];
      };

      settings = {
        env_file = "${config.home.homeDirectory}/.mise_env";
        experimental = true;
        go_default_packages_file = "${config.home.homeDirectory}/mise/golang";
        python.default_packages_file = "${config.home.homeDirectory}/mise/python";
        ruby.default_packages_file = "${config.home.homeDirectory}/mise/ruby"; 
      };

      env = {
        LDFLAGS = "-L${pkgs.openssl.dev}/lib -L${pkgs.libyaml.dev}/lib";
        CPPFLAGS = "-I${pkgs.openssl.dev}/include -I${pkgs.libyaml.dev}/include";
        PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.libyaml.dev}/lib/pkgconfig";
      };
    };
  };
}

