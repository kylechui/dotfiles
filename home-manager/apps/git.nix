{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Kyle Chui";
        email = "kyle.chui+github@pm.me";
      };
      alias = {
        hash = "rev-parse HEAD";
      };
    };
    iniContent = {
      commit.gpgSign = true;
      gpg.format = "ssh";
      user.signingKey = "~/.ssh/id_ed25519.pub";
      init.defaultBranch = "main";
      merge.tool = "nvimdiff";
      mergetool = {
        keepBackup = false;
        # Focus cursor on the middle (merged) window
        nvimdiff.cmd = "${pkgs.unstable.neovim}/bin/nvim -d $LOCAL $MERGED $REMOTE -c 'wincmd l'";
      };
      # Fix mouse scrolling issues for `delta`
      # https://github.com/dandavison/delta/issues/630#issuecomment-860046929
      pager.diff = "LESS='R --mouse' ${pkgs.delta}/bin/delta";
      pager.show = "LESS='R --mouse' ${pkgs.delta}/bin/delta";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      features = "navigate";
      side-by-side = true;
      line-numbers = true;
    };
  };
}
