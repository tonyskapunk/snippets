#!/usr/bin/env python
''' Removes/Installs packages and mark them as not installed from user.
'''

import sys
try:
    import apt
except ImportError:
    print('Error, python apt library not found')
    sys.exit(1)


def rminst(packagename="figlet"):
    '''A test function to install/remove a package automagically.
    '''
    ac = apt.Cache()
    pkg = ac[packagename]
    if pkg.is_installed:
        print('{} [{}] (autoinst? {}) (autorm? {})'.format(
            pkg.name,
            pkg.installed.version,
            pkg.is_auto_installed,
            pkg.is_auto_removable))
        print('Package installed, attempting to purge it...')
        pkg.mark_delete(purge=True)
    else:
        print('Package not installed, attempting to install it...')
        pkg.mark_install(from_user=False)
    try:
        ac.commit(install_progress=None)
    except SystemError:
        print('Failed to commit changes.')
        sys.exit(1)


def main():
    rminst(sys.argv[1])

if __name__ == "__main__":
    main()
