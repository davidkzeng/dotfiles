""" Manages installs accross multiple package managers """

import subprocess
import shutil
import sys

from sources import packages, sources, default_install

def command_exists(command):
    return shutil.which(command) is not None

def do_install():
    installed_packages = {}
    
    system_sources = set()

    for source, source_spec in sources.items():
        if command_exists(source): 
            print('Getting installed packages for source %s' % source)
            source_installed = source_spec['installed']()
            installed_packages[source] = source_installed
            system_sources.add(source)
        else:
            print('Source %s does not exist' % source)

    for package in default_install:
        print('Package %s ...' % package)
        installed = False
        package_spec = packages[package]
        package_sources = package_spec['sources']
        for package_source in package_sources:
            if package in installed_packages[package_source]:
                print('Package {package} installed by source {source}'
                    .format(package=package, source=package_source))
                installed = True
                break

        # NOTE: Remove if this no longer holds for a package
        if not installed and command_exists(package):
            print('Package %s installed by unknown source' % package)
            installed = True

        if not installed:
            for package_source in package_sources:
                if package_source not in system_sources:
                    continue
                
                print('Package {package} ... installing from source {source}'
                    .format(package=package, source=package_source))
                options = sources[package_source]['options']
                format_kwargs = {}
                for option in options:
                    if option == 'name':
                        format_kwargs['name'] = package
                    else:
                        assert option in package_spec
                        format_kwargs[option] = package_spec[option]
                command = sources[package_source]['command'].format(**format_kwargs)
                print('Running command %s' % command)
                # Slightly hacky way to run without shell=True
                result = subprocess.run(command.split())
                if result.returncode == 0:
                    print('Successfully installed command')
                else:
                    print('Failed to install command, aborting')
                    sys.exit(1)

do_install()
