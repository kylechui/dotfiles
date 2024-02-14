{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Kyle Chui";
    userEmail = "kyle.chui+github@pm.me";
    difftastic.enable = true;
    iniContent = {
      commit.gpgSign = true;
      gpg.format = "ssh";
      user.signingKey = "~/.ssh/id_ed25519.pub";
      init.defaultBranch = "main";
      merge.tool = "nvimdiff";
      mergetool = {
        keepBackup = false;
        # Focus cursor on the middle (merged) window
        nvimdiff.cmd =
          "${pkgs.neovim-nightly}/bin/nvim -d $LOCAL $MERGED $REMOTE -c 'wincmd l'";
      };
      # Better diffing
      diff.tool = "difftastic";
      difftool = {
        prompt = false;
        difftastic.cmd = "${pkgs.difftastic}/bin/difft $LOCAL $REMOTE";
      };
      pager.difftool = true;
    };
  };
}
