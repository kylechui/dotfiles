{
  services.autorandr.enable = true;
  programs.autorandr = {
    enable = true;
    profiles = {
      mobile = {
        fingerprint = {
          eDP-1 =
            "00ffffffffffff0006af2d5e00000000271c0104a51d1178032ea5a5544a9b270e505400000001010101010101010101010101010101b43780a070383e403a2a350025a510000018232580a070383e403a2a350025a51000001800000000000000000000000000000000000000000002001430ff123cc8320614c820202000f2";
        };
        config = {
          DP-1.enable = false;
          eDP-1 = {
            enable = true;
            primary = true;
            mode = "1920x1080";
            rate = "60.03";
          };
        };
      };
      docked = {
        fingerprint = {
          eDP-1 =
            "00ffffffffffff0006af2d5e00000000271c0104a51d1178032ea5a5544a9b270e505400000001010101010101010101010101010101b43780a070383e403a2a350025a510000018232580a070383e403a2a350025a51000001800000000000000000000000000000000000000000002001430ff123cc8320614c820202000f2";
          DP-1 =
            "00ffffffffffff001e6dd25b5e7d0400091f010380462778eacf85a85643ab250f5054210800d1c06140454001010101010101010101747400a0a0a0535030203500b9882100001a000000fd0030901ee63c000a202020202020000000fc004c4720554c545241474541520a000000ff003130394d58554e384e3233380a015002033ec1230907074d100403011f13133f5d5e5f5f5f6d030c002000803c2000600102036700000001788003e30f0018e2006ae3050000e6060000000000376100a0a0a0555030203500b9882100001a565e00a0a0a0295030203500b9882100001a00000000000000000000000000000000000000000000000000000000006a";
        };
        config = {
          eDP-1.enable = false;
          DP-1 = {
            enable = true;
            primary = true;
            mode = "2560x1440";
            rate = "71.97";
          };
        };
      };
    };
  };

}
