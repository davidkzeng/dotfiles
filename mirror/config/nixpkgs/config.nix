{
    packageOverrides = pkgs: with pkgs; {
        myPackages = pkgs.buildEnv {
            name = "my-packages";
            paths = [
                # nix related
                nix-tree
                nixfmt

                # core dev environment
                neovim
                tmux
                zsh

                # misc. dev environment
                direnv
                fzf
                ripgrep
                cloc

                # data manipulation
                jq
                xsv

                # dev languages, tools
                git
                sqlite
                gnumake
                sumneko-lua-language-server
                patchelf

                # personal apps
                pandoc
                zola
                htop
                screenfetch
            ];
            pathsToLink = [ "/share" "/bin" ];
            extraOutputsToInstall = [ "man" "doc" ];
        };

        myExtraPackages = pkgs.buildEnv {
            name = "my-extra-packages";
            paths = [
                (texlive.combine {
                    inherit (texlive) scheme-medium enumitem;
                })
            ];
            pathsToLink = [ "/share/man" "/share/doc" "/bin" ];
            extraOutputsToInstall = [ "man" "doc" ];
        };
    };
}
