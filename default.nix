let
  overlay = self: super: {
    haskellPackages = super.haskellPackages.extend (hself: hsuper:
      let
        eve-source = super.fetchFromGitHub {
          owner = "bradparker";
          repo = "eve";
          rev = "942b94c39298ee8485f2e0c2375e1ccf678fd189";
          sha256 = "1jvxskc8fa09wllxzw80qjv62x1plj1mpksx94sq0jd2xaf0m08d";
        };
        rasa-source = super.fetchFromGitHub {
          owner = "ChrisPenner";
          repo = "rasa";
          rev = "4dd652f9b8e042b89006640299bae48babed8f74";
          sha256 = "0m5a5q5m04rb71sw4dfhdgsz03hzvsrqhfiz8jkbagpmkf8nnrjh";
        };
      in
        {
          eve = hself.callCabal2nix "eve" eve-source {};
          rasa = super.haskell.lib.doJailbreak (hself.callCabal2nix "rasa" "${rasa-source}/rasa" {});
          rasa-ext-cmd = hself.callCabal2nix "rasa-ext-cmd" "${rasa-source}/rasa-ext-cmd" {};
          rasa-ext-cursors = hself.callCabal2nix "rasa-ext-cursors" "${rasa-source}/rasa-ext-cursors" {};
          rasa-ext-files = hself.callCabal2nix "rasa-ext-files" "${rasa-source}/rasa-ext-files" {};
          rasa-ext-logger = hself.callCabal2nix "rasa-ext-logger" "${rasa-source}/rasa-ext-logger" {};
          rasa-ext-slate = hself.callCabal2nix "rasa-ext-slate" "${rasa-source}/rasa-ext-slate" {};
          rasa-ext-views = hself.callCabal2nix "rasa-ext-views" "${rasa-source}/rasa-ext-views" {};
          rasa-ext-vim = hself.callCabal2nix "rasa-ext-vim" "${rasa-source}/rasa-ext-vim" {};
          text-lens = hself.callCabal2nix "text-lens" "${rasa-source}/text-lens" {};
          vty = hself.callHackage "vty" "5.25" {};
        }
      );
  };
  nixpkgs = import <nixpkgs> {
    overlays = [overlay];
  };
in
  nixpkgs.haskellPackages.callCabal2nix "editor-two" ./. {}
