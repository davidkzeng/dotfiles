import subprocess
import tempfile

def get_installed_apt_packages():
    packages = set()
    # Capture stderr and ignoring due to unimportant error messages
    result = subprocess.run(['apt', 'list', '--installed'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
    output = result.stdout
    for line in output.splitlines():
        if '/' in line:
            package_name = line.split('/')[0]
            packages.add(package_name)
    return packages

def get_installed_snap_packages():
    packages = set()
    result = subprocess.run(['snap', 'list'], stdout=subprocess.PIPE, universal_newlines=True)
    output = result.stdout
    for line in output.splitlines():
        package_name = line.split()[0]
        packages.add(package_name)
    return packages

sources = {
    'apt': {
        'options': ['name'],
        'command': 'apt install {name}',
        'installed': get_installed_apt_packages
    },
    'snap': {
        'options': ['name'],
        'command': 'snap install {name}',
        'installed': get_installed_snap_packages
    }
}

packages = {
    'neovim': {'sources': ['apt']},
    'tmux': {'sources': ['apt']},
    'git': {'sources': ['apt']},
    'htop': {'sources': ['apt']}
}

default_install = ['neovim', 'tmux', 'git', 'htop']
