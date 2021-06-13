{
    packageOverrides = pkgs: with pkgs; {
        myPackages = pkgs.buildEnv {
            name = "my-packages";
            paths = [
                # nix related
                nix-tree
                nixfmt

                # core dev environment
                git
                neovim
                tmux
                zsh

                # misc. dev environment
                direnv
                fzf
                ripgrep
                shellcheck

                # dev languages, tools
                nodejs
                sqlite

                linuxPackages.perf

                # personal apps
                pandoc
                zola
                htop
                neofetch
            ];
        };
        pathsToLink = [ "/share/man" "/share/doc" "/bin" ];
        extraOutputsToInstall = [ "man" "doc" ];
    };
}
