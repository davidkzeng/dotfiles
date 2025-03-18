{
    packageOverrides = pkgs: with pkgs; {
        myPackages = pkgs.buildEnv {
            name = "my-packages";
            paths = [
                # nix related
                nix-tree

                # core dev environment
                neovim
                helix
                tmux
                zsh

                # misc. dev environment
                direnv
                fzf
                ripgrep
                cloc

                # data manipulation
                jq

                # dev languages, tools
                git
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
    };
}
