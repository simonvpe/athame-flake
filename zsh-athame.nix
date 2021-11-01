{ athame, vimbed, zsh, neovim, stdenv }:

zsh.overrideAttrs (orig: {
  inherit athame vimbed;
  ATHAME_VIM_BIN = "${neovim}/bin/nvim";
  ATHAME_USE_JOBS_DEFAULT = "1";
  patches = (orig.patches or []) ++ [ "${athame.outPath}/zsh.patch" ];
  postPatch = ''
    (
      cd ./Src/Zle
      ln -s $vimbed vimbed
      ln -s $athame/athame{.c,.h,_util.h} ./
      ln -s $athame/athame_zsh.h ./athame_intermediary.h
    )
  '';
  postInstall = ''
    ${orig.postInstall or ""}
    cp $athame/athamerc $out/etc/
  '';
})

