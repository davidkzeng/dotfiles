{
    packageOverrides = pkgs: with pkgs; {
        myPackages = pkgs.buildEnv {
            name = "my-packages";
            paths = [
                direnv
                fzf
                git
                htop
                linuxPackages.perf
                neovim
                nix-tree
                nixfmt
                pandoc
                ripgrep
                shellcheck
                tmux
                zola
                zsh
            ];
        };
        pathsToLink = [ "/share/man" "/share/doc" "/bin" ];
        extraOutputsToInstall = [ "man" "doc" ];
    };
}
