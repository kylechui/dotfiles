{
  programs.git = {
    enable = true;
    userName = "Kyle Chui";
    userEmail = "kyle.chui+github@pm.me";
    iniContent = {
      commit.gpgSign = true;
      gpg.format = "ssh";
      user.signingKey = "~/.ssh/id_ed25519.pub";
      init.defaultBranch = "main";
      merge.tool = "nvimdiff";
      mergetool = {
        keepBackup = false;
        # Focus cursor on the middle (merged) window
        nvimdiff.cmd = "nvim -d $LOCAL $MERGED $REMOTE -c 'wincmd l'";
      };
    };
  };
}
