{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # C/C++
      gcc
      llvmPackages_15.clang-unwrapped
      # Rust
      cargo
      # Python
      python3
      black
      # JavaScript/TypeScript
      typescript
      nodejs
      # OCaml
      ocaml
      ocamlformat
      # Haskell
      ghc
      haskell-language-server
      stylish-haskell
      # Nix
      rnix-lsp
      nixfmt
      # Lua
      sumneko-lua-language-server
      stylua
      # LaTeX
      texlab
    ];
  };

  programs.opam.enable = true;
  programs.texlive = {
    enable = true;
    extraPackages = tpkgs: { inherit (tpkgs) scheme-full; };
  };
}
