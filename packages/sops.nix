{ vimUtils, fetchFromGitHub }:

vimUtils.buildVimPlugin {
  pname = "sops-nvim";
  version = "unstable-2026-07-11";

  src = fetchFromGitHub {
    owner = "trixnz";
    repo = "sops.nvim";
    rev = "4de0cb71746d7a6de6311c85bc39873e56bcefc7";
    hash = "sha256-pMnAGm7tkgM5pxhNEs06Qdx69qztMd14uNpuRi4I4qE=";
  };
}
