function list-apt-manual() {
    comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)
}

function list-apt-repos() {
    (echo /etc/apt/sources.list && find /etc/apt/sources.list.d/ -regex '.*list') | xargs egrep -v '^#|^ *$'
}

function lfz() {
    less $(fzf)
}

function vfz() {
    vim $(fzf)
}

