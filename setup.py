#!/usr/bin/env python
# -*- coding: utf-8 -*-

try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

import taravel
version = taravel.__version__

setup(
    name='taravel',
    version=version,
    author='',
    author_email='naczelnik@jawnosc.tk',
    packages=[
        'taravel',
    ],
    include_package_data=True,
    install_requires=[
        'Django>=1.7.10',
    ],
    zip_safe=False,
    scripts=['manage.py'],
)
