{
    packageOverrides = pkgs: with pkgs; {
        myPackages = buildEnv {
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
                nodejs
                sqlite
                gnumake
                linuxPackages.perf

                # personal apps
                pandoc
                zola
                htop
                neofetch
            ];
            pathsToLink = [ "/share/man" "/share/doc" "/bin" ];
            extraOutputsToInstall = [ "man" "doc" ];
        };

        extraPackages = buildEnv {
            name = "extra-packages";
            paths = [
                texlive.combined.scheme-medium # large install
            ];
            pathsToLink = [ "/share/man" "/share/doc" "/bin" ];
            extraOutputsToInstall = [ "man" "doc" ];
        };
    };
}
