{
  inputs,
  ...
}:
{

  flake-file.inputs.robotnix = {
    url = "github:nix-community/robotnix";
    # inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules = {
    nixos.robotnix = {
      programs.ccache.enable = true;
      nix.settings.extra-sandbox-paths = [ "/var/cache/ccache" ];
    };
  };
  flake.robotnixConfigurations.rodin = inputs.robotnix.lib.robotnixSystem (
    { pkgs, ... }:
    {
      flavor = "lineageos";

      # device codename - FP4 for Fairphone 4 in this case.
      # Supported devices are listed under https://wiki.lineageos.org/devices/
      device = "rodin";

      # LineageOS branch.
      # You can check the supported branches for your device under
      # https://wiki.lineageos.org/devices/<device codename>
      # Leave out to choose the official default branch for the device.
      flavorVersion = "22.2";

      # Enables ccache for the build process. Remember to add /var/cache/ccache as
      # an additional sandbox path to your Nix config.
      ccache.enable = true;

      # === VENDOR BLOB INTEGRATION ===
      source.dirs."vendor/xiaomi/rodin" = {
        src = pkgs.fetchgit {
          url = "https://github.com/ibrahim-akrab/proprietary_vendor_xiaomi_rodin.git";
          rev = "refs/heads/lineage-22.2";
          sha256 = "sha256-Ppk3+0FriVlBtvL0wD4UJRmuULriATvugDZgbirWpF4="; # Replace with actual hash after first build
          fetchLFS = true;
        };
      };

      # === DEVICE TREE ===
      source.dirs."device/xiaomi/rodin" = {
        src = pkgs.fetchFromGitHub {
          owner = "ibrahim-akrab";
          repo = "android_device_xiaomi_rodin";
          rev = "lineage-22.2";
          sha256 = "sha256-JUnJnMsapP1mh9mKNQNsSA/TSOkzjeddic3yMATRY+E="; # Replace with actual hash after first build
        };
      };

      # === ESSENTIAL HARDWARE SUPPORT ===
      # These are required for proper MediaTek and Xiaomi hardware functionality

      # Xiaomi-specific hardware abstraction layers
      # Provides: fingerprint, sensors, telephony, vibrator drivers
      source.dirs."hardware/xiaomi" = {
        src = pkgs.fetchFromGitHub {
          owner = "mt6899-rodin";
          repo = "android_hardware_xiaomi";
          rev = "lineage-22.2";
          sha256 = "sha256-jbpBwSCPoF3scYiUmICErhtqsToThAG4PwHUTsOE8ME="; # Replace with actual hash after first build
        };
      };

      # MediaTek-specific hardware components
      # Provides: BesLoudness, sensors, WiFi HAL, power management
      source.dirs."hardware/mediatek" = {
        src = pkgs.fetchFromGitHub {
          owner = "mt6899-rodin";
          repo = "android_hardware_mediatek";
          rev = "lineage-22.2";
          sha256 = "sha256-l0JX3dITwdZhO+J17bjebOUJT1p+u3b7483lFsoVpRw="; # Replace with actual hash after first build
        };
      };

      # === KERNEL INTEGRATION ===
      # Prebuilt kernel with MediaTek MT6899 support
      # Contains: kernel image, DTBO, kernel modules for system/vendor
      source.dirs."device/xiaomi/rodin-kernel" = {
        src = pkgs.fetchFromGitHub {
          owner = "mt6899-rodin";
          repo = "android_device_xiaomi_rodin-kernel";
          rev = "lineage-22.2";
          sha256 = "sha256-xAWPjEcpWXtobgisBQlK760c4Jh6EEjCBHZYWyTRdjQ=";
        };
      };

      # === SELINUX SECURITY POLICIES ===
      # Essential MediaTek SELinux policies for proper system security
      # Provides: modem, BSP, and legacy policy rules
      source.dirs."device/mediatek/sepolicy_vndr" = {
        src = pkgs.fetchFromGitHub {
          owner = "mt6899-rodin";
          repo = "android_device_mediatek_sepolicy_vndr";
          rev = "lineage-22.2";
          sha256 = "sha256-+DVgzFG3NG6KcZWQzXaMC6kf1M6yHymz9JUiryOeSrI=";
        };
      };

      # === MEDIATEK IMS SUPPORT ===
      # Essential MediaTek IMS (IP Multimedia Subsystem) package for Mediatek devices
      source.dirs."vendor/mediatek/ims" = {
        src = pkgs.fetchFromGitHub {
          owner = "redmi-mt6899-devs";
          repo = "vendor_mediatek_ims";
          rev = "lineage-22.2";
          sha256 = "sha256-y9ZVElmzsGk+mWftsM+Na0pcbuKAm7Kc2yhJFig6Vrc=";
        };
      };

      # === APPS AND FEATURES ===
      apps.fdroid = {
        enable = true;
        additionalRepos = {
          mollyim = {
            enable = true;
            url = "https://molly.im/fdroid/foss/fdroid/repo";
            pubkey = "3082053130820319a00302010202044598b6a0300d06092a864886f70d01010b050030493120301e060355040a13174d6f6c6c7920496e7374616e74204d657373656e6765723110300e060355040b1307462d44726f6964311330110603550403130a4f73636172204d697261301e170d3230313031333032353534395a170d3438303232393032353534395a30493120301e060355040a13174d6f6c6c7920496e7374616e74204d657373656e6765723110300e060355040b1307462d44726f6964311330110603550403130a4f73636172204d69726130820222300d06092a864886f70d01010105000382020f003082020a0282020100b249333b8017c58c84c6341e510637936bec51e7f36b1127b882020a2a9b8007abba407c12628b9156416f69850ebba9f1ba881d827a8874a018ac1efaac22ce9f07ee8a414df027410d6a8359b6799b764fb0e7a13339348d34f6a697dc7ff79f2e6cbfbda8213d243b265792ec6478aefd310c395494d245b6038a836d13f290ef3f3cba10d507456413294a0ad6eb9b1852605c93c00b14ba9d4c42fa7b72dbe3f492b412d39e45cf3a75a2c8bcb27c0c81cf49a626f1f0972c31967a785accc49a4992bbbaec5060659ed17a533a09071da00b37bd617f901027951d292cdc3bda63e2778ea458b3a243df3ade6e25a662bf1d0e1f8966a2bec405bab4829f954a624206ccbbbaed02556eb2fddf48238e50380be56c1ba1defc42b1ba958de355f12a35c0f4f679ffe3b0a7b027092c47c2d672dd6ab19c2cb23b58dcc3fa7a4a904d39d2ac7eac8e2e239bfd3688c2f59f9cb80f2174c0165582c1003a7ab2006df4f3216a635b30e9a2bbb062b07c81656063006fc126ffb4c8a9c64674f186dd480be8216d16e5ab2d03092166a2f64f1dbae0c564a55c9b77a157e69957454f4d4a62cc9368964679c36f0b187cb00239444210e1ec7d51d45bbfbdf96701d3df20fb51affbf891cb1bd65fd917c15a9999c56322c41c70ab2f0b821bc8977f5bc69de392e7a7977d5f2ff83282576cf7927ba2a1111d9f0c6b0f210203010001a321301f301d0603551d0e04160414d3ee008c3f0af19fa46528e17691c4cc6657b9fd300d06092a864886f70d01010b0500038202010030b9226f391f9df96fbea9fd8111b1bf3dd1b2947a6dc2044fdff7c3b7c261557d4d2e8dc398b5ed0a7bc5b666a2f894c40a4a156e4412720a6219a445aec6074bbd2378a0b82d46d245318b954d0841a4e5909c259871fcd93941fcae7b4a8f884b55bdc3a0af57caa5797fbf1e26ed625cb1e03a6b47e31d0c6afb447804f2de605facf3d0c35f4e410d3a59706a482831cf7ab72057363848919a2f854ae3279fcc246277f3493f3b88cac12bb6500d63981d2fe2126579e931b3882879a8df2404d36b415887b652402c70d5eeba627f96a1ea2e095e60e55d5d3e678516551e501eb2d675b2cc7fe9b9d3e923e411b773fb8f643855ddf1f09bae72f6d0c27925e3c245ef7bb665bb0ee531ad4fb3fec9f0f54d016e4111fecbd613c1ea4bad69a385c6c90706c6bdeaad2f08292594e951ef7a729eda3f7b8a1959b2d49fc032eab02e097b482bb85577e27a6700ac188be4581d5b0e27b4f1b22dc0c44b45e4dd2acd3934b8dd557106fc9bf0a2402ad2e72d43a090a4a4fb2ccd5fc3f0add400f91b9e22a5740cc27a1d494b651456a871dfece9aa35366f2fae1905f41c3b04dca0386889507f57c1e3eff05f30cb87e38d1d1f45c2c05815bde12f11225c22467e6ea5af04c1f3f1a0d60592c701f7ea00e809bc46f92759949a57294d13e6bad30cb31f111ace4433a634e407684282e127a67aa346487ca49b85";
          };
          bitwarden = {
            enable = true;
            url = "https://mobileapp.bitwarden.com/fdroid/repo";
            pubkey = "3082050b308202f3a003020102020450bb84bb300d06092a864886f70d01010b050030363110300e060355040b1307462d44726f6964312230200603550403131962697477617264656e2d5669727475616c2d4d616368696e65301e170d3139303630373031323531305a170d3436313032333031323531305a30363110300e060355040b1307462d44726f6964312230200603550403131962697477617264656e2d5669727475616c2d4d616368696e6530820222300d06092a864886f70d01010105000382020f003082020a02820201008d80ad2dec6a0a227fc4ccf55b20c1c968f375fadf457fd6fd03a5f0eec0743fcb037595fa450603faa94c1c49307786e591c5f4324704ed087491f6329d6921ab82402a7b2b65c14d0443e390f44e0e43af606b6aee8be0ad6fcaa808b2b68cd275844a1496e187a47a9546fed59fea48f1ee4eef6ee2b8df2d0139e6bf0dc58bd1adfcb9b6545dd0fe9ad1c685ed09692aa202745d2cbe3f43b917fdfd8fdf2ac9f01f09dd4c2a5eb3401e1648912b324c3b96dba361fc2ff7308456179ebb7fa4e6700a9af986829bb63c27ddb02c4881ec272446c3bcb286ebfcd50b1ff4e3864bc447d164400982f97c89380094e1ac146ecdf7c36469bfc6a17a177cd6f6bd14695b1858358af6a2b2f32e9ac457539ce2b19a986354483b77acbd0544863becd437ff11bb1bc9d2493b93607049c31b1cc72a81d4bfeac2eb2e49c0ab3be8037ffa2e2df90a3cf8bb2d90e37d20f917d3b56cc308fd0fa49b111daca230d77028b82285085a3c896561c8000f61b3aeb102ecf67c9466a62854bf477f82def889a6fe2d606fc296387bf70c4250188c80a292cd563a5bde28eebd7911822a01ff8667dce1324cab735b60d18f0cce3a114bb72ae0019c0f93adc1a2a8d81be9782c78d724d9917eee6b1c81a751b009f18828cf17593c1a52e27a35b03aece4f03a8dcf280557d9294d6f95df44bdeef8be32321a1397b09fb72848990203010001a321301f301d0603551d0e04160414fd6084b86a35190c8c2e14bde4ece1950c22c603300d06092a864886f70d01010b050003820201005af4595384cb93cc1be2f0afbfea9b5f7d730ed38cb15410dde9eaa1b4399229e9bef1237cb72a30978211651ba5d4c54a42815f3560fe5c6bc681b560e68cbb3783f93ce5c464900748d94a254f971bf216504c83dddf22687e1417f4b0f856054ec179ca6a40d590452eb420742238f0745e0d7aea7e2480f754d1e3d222aca89db4728b339f8f15824f6787c8f65236ec76812a3223426a24e2d86c180cf7b792f9609b1f60a3c52c1eeb976f0195ed279f30a575746e9092dcf9682f3a577b67099e2bc1f2a0315feddd2b575c94bdd60db4213f93ea6b5597c55944d3e86f73cd5c5d166d8eefdc78aea1ae66b8dfb166198fe0cfdfba348b884357f506335328432b1cae8eac5f1bd34442f30d68dbeef6b97ca1b169dc6f3c0a6d57396a09785f4a4de5853ba7a53cf92636d25a3e1d7af183b7b94b93a2aa4821aa5e9b684d1f756fde036cdc666c40fcefe65fe6be29af71440517e1f9fb3039c3394d0c3989d6f75a7675a659c568f8255080d9dcccb42f7243cf2ba1d317d432a584f095bc2ef9e394b1be16055e3a0feee66c4f0dc78854f13fbfb814ba001fa99a454dfa97684c37d71eff1959ce05b455ac3f80b960c824e2b39d985c9cf8b2d25d5c51252c547c29060b9e7e78eb53b0492f0aef0c6839c7850c95bf68038c02c5cacd6f7f43c0db065b0296ea1c313e0cec92a87edcaeb3ae4a2f51ee169d";
          };
          microG = {
            enable = true;
            url = "https://microg.org/fdroid/repo";
            pubkey = "308202ed308201d5a003020102020426ffa009300d06092a864886f70d01010b05003027310b300906035504061302444531183016060355040a130f4e4f47415050532050726f6a656374301e170d3132313030363132303533325a170d3337303933303132303533325a3027310b300906035504061302444531183016060355040a130f4e4f47415050532050726f6a65637430820122300d06092a864886f70d01010105000382010f003082010a02820101009a8d2a5336b0eaaad89ce447828c7753b157459b79e3215dc962ca48f58c2cd7650df67d2dd7bda0880c682791f32b35c504e43e77b43c3e4e541f86e35a8293a54fb46e6b16af54d3a4eda458f1a7c8bc1b7479861ca7043337180e40079d9cdccb7e051ada9b6c88c9ec635541e2ebf0842521c3024c826f6fd6db6fd117c74e859d5af4db04448965ab5469b71ce719939a06ef30580f50febf96c474a7d265bb63f86a822ff7b643de6b76e966a18553c2858416cf3309dd24278374bdd82b4404ef6f7f122cec93859351fc6e5ea947e3ceb9d67374fe970e593e5cd05c905e1d24f5a5484f4aadef766e498adf64f7cf04bddd602ae8137b6eea40722d0203010001a321301f301d0603551d0e04160414110b7aa9ebc840b20399f69a431f4dba6ac42a64300d06092a864886f70d01010b0500038201010007c32ad893349cf86952fb5a49cfdc9b13f5e3c800aece77b2e7e0e9c83e34052f140f357ec7e6f4b432dc1ed542218a14835acd2df2deea7efd3fd5e8f1c34e1fb39ec6a427c6e6f4178b609b369040ac1f8844b789f3694dc640de06e44b247afed11637173f36f5886170fafd74954049858c6096308fc93c1bc4dd5685fa7a1f982a422f2a3b36baa8c9500474cf2af91c39cbec1bc898d10194d368aa5e91f1137ec115087c31962d8f76cd120d28c249cf76f4c70f5baa08c70a7234ce4123be080cee789477401965cfe537b924ef36747e8caca62dfefdd1a6288dcb1c4fd2aaa6131a7ad254e9742022cfd597d2ca5c660ce9e41ff537e5a4041e37";
          };
          IzzyOnDroid = {
            enable = true;
            url = "https://apt.izzysoft.de/fdroid/repo";
            pubkey = "308204e1308202c9a003020102020454c60934300d06092a864886f70d01010b050030213110300e060355040b1307462d44726f6964310d300b060355040313046e65626f301e170d3136303331303230313634325a170d3433303732373230313634325a30213110300e060355040b1307462d44726f6964310d300b060355040313046e65626f30820222300d06092a864886f70d01010105000382020f003082020a0282020100ac59258ca2e9c216af14d58cb53adb13658480aed5ebc1f59bfc474f0f67c0efe9d58304d0cbda2897bd3283e7afe15512f32743ee243f4b9bba5a017806bc5c3441c905df37d00d3cf77b012af33ee4033b7e8d686277043bcb28241a3fe9f6ebfd72f305a928e300edf554ffaa139d85b5c9282aa8f1a82ff74caea2c13006dbeae8aac9ff44fa4c9122808b90c304db8b9e6ddecdbfbf5ce4ed0115cf1ba2bc6a4d6211765553df9b650db69155448aec4b0aaf59d19712aca3010a0d96eb02ed84e90c16162272af32fe909a5acde37d78fba500994f50c1ec5afa528945a7567567560a9fbafbabd68190c5c13f9a53f39a72734bd8de43c06b21a5cecf2747e6a1879352c49ee29fa092c26ca495baac69eddb614941e27b6a27fb3fb74cbdfe5822bfc266130c1f723a7ab91ed3d6c5261d31fc80ab82b7caa2727120522e65863af436a438c05039e1e099faae4d6170baa10fc9bb7bf101e2b4c9769e693eb7e4e3eebd47bfbfe0069c24a8b1ef72d8fe6549202490cff7b0f36c458b8192fe58f984839290d69639abb15fe1ef2925eb491627f2eefbd13225b925a7bbfc0fb4d95a3fb43599c172037e599639b4f86c4eabc173013776a854e146dfacf424cbae4254f9806ecd79d092f5e67a2f00c98ad64c0bfbeaff117fe4c62685e2e75e2ef507325d05f866510c20006a6c01e8e25d75bd42a0d5397b73eb0203010001a321301f301d0603551d0e0416041417f4fd41b0aa3f4fa981423a123f6f6016e3ce80300d06092a864886f70d01010b050003820201008d5d93cbb48fde9df566d75c54a8da2f29e9ae1bac2ed2436a0f165730244ac9e471b473674bc68717c34e30c29ce5ffa027fa12a7eb2f45b036db0cca79238262ba84f6ec8ffddcfe2b398c0a6aa33d117f83996b3bece96b1ea6f8066c395e5021c2b5fe1638c7ac146cda6ef2e4a836bd9c968ed76c51cc0b09caa4b1a79d5d10b3829804db992a70feb9a76535bc04631193abee9c9d7ebfb07ad464542f65744e76d92c5aeb3beb96dbb0b3d746845cbfa2b12c6da31863ea4a0d664dc5974d5b808c1be52a5e595ed181d86feeff4dc82bc8ee3c11ff807a811322931e804df1d90b5b813dd9ce81f3d8dd7d1bb2994901fe1c1004673f53c7b60cdbc2f914ce0718fbfc8e89b443091f71ecb9f169d558c3818bb1db714a47025154eb974600ca54e29933a87a4080910eee05dcc34de7048fa95b1128d8910b18b5957f2e745de00decd2434af455b24aa3e53de889e37919212a6adb3f4088baec6cc9f3e21b812593605fba0394355bd994f21ceaba861aae29244f5113d4291fdddedbef091e63885ebf318c6e12d338fa9555783643a19181c2cc935307fcee5e6dabf8dd6e19a92b29dbc529d3ef170916fb7b2d9dbf95a358ac7c0204b6e6a416b59441c49c41d6f78b1de63eb8b10c516a5952a20eb0c595cfa21530350c5adde74d815918deb870a9e7750fcb4dc50538fd591006434cbbb001cc2ae1fe11";
          };
        };

      };
      apps.prebuilt.F-Droid.fingerprint = "DB1BA1EF674257FADA39682BF05D93178621B2C0E8A77E5842CAC13405BEAE12"; # sha256 of the certificate used to sign apk (f-droid.x509.pem)
      apps.seedvault.enable = true;
      microg.enable = true;

      # Reduce memory usage for MediaTek builds if needed
      # buildNumber = "1"; # Set a fixed build number
      # buildDateTime = "2025-01-01T00:00:00Z"; # Reproducible builds

      # === SIGNING (for production builds) ===
      signing.enable = true;
      # fix for missing com.android.hardware.boot keys in AOSP
      signing.apex.packageNames = [ "com.android.hardware.boot" ];
    }
  );
}
