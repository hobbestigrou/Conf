#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os

from fabric.api import run, sudo, cd, task
from fabtools import require
import fabtools

import shutil
from functools import wraps


def get_directory(directory):
    home = fabtools.user.home_directory('hobbestigrou')
    return home + '/' + directory


def setup_directory(directory, git_url):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            param_directory = get_directory(directory)

            if os.path.exists(directory):
                shutil.rmtree(param_directory)
            fabtools.git.clone(git_url)

            return func(*args, **kwargs)
        return wrapper
    return decorator


def simple_compile(directory):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            func(*args, **kwargs)
            with cd(get_directory(directory)):
                run('./build.sh')
                sudo('make install')

        return wrapper
    return decorator


@task
@setup_directory('the_silver_searcher',
                 'https://github.com/ggreer/the_silver_searcher')
@simple_compile('the_silver_searcher')
def install_ag():
    '''Install the silver search like ack-grep but more speed'''
    require.deb.packages(['automake', 'pkg-config', 'libpcre3-dev',
                          'zlib1g-dev', 'liblzma-dev'])


@task
def get_background():
    require.deb.packages(['feh'])

    run('wget http://bitbucket.org/tednaleid/vim-shortcut-wallpaper/raw/tip'
        '/vim-shortcuts.png')
    run('feh --bg-fill vim-shortcuts.png')


@task
def vim():
    '''To install Vim and vim-mahewin-repository'''
    require.deb.packages(['vim-nox', 'curl'])
    run('curl -L https://github.com/hobbestigrou/Vim-Mahewin-Repository/raw'
        '/master/install.sh | bash')


@task
def full_install():
    '''To install all tools for a desktop like qtile, vim, background'''
    install_ag()
    get_background()
    vim()
