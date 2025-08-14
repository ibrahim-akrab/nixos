{
  flake.modules.homeManager.desktop = {
    programs.librewolf = {
      enable = true;
      settings = {
        "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "security.tls.version.enable-deprecated" = true;
        "security.tls.version.min" = 1;
        "security.ssl.require_safe_negotiation" = false;
        "browser.tabs.inTitlebar" = 0;
      };
    };
  };
}
