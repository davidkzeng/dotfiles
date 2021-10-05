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
                nodejs
                sqlite
                gnumake
                google-cloud-sdk
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
        fullPackages = pkgs.buildEnv {
            name = "full-packages";
            paths = [
                texlive.combined.scheme-full # large install
            ];
        };
    };
}
