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
                shellcheck
                cloc

                # data manipulation
                jq
                xsv

                # dev languages, tools
                git
                sqlite
                gnumake
                linuxPackages.perf

                # personal apps
                pandoc
                zola
                htop
                screenfetch
            ];
            pathsToLink = [ "/share/man" "/share/doc" "/bin" ];
            extraOutputsToInstall = [ "man" "doc" ];
        };

        extraPackages = buildEnv {
            name = "extra-packages";
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
