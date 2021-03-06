taravel
==============================

.. image:: https://pyup.io/repos/github/ad-m/taravel/shield.svg
     :target: https://pyup.io/repos/github/ad-m/taravel/
     :alt: Updates

.. image:: https://pyup.io/repos/github/ad-m/taravel/python-3-shield.svg
     :target: https://pyup.io/repos/github/ad-m/taravel/
     :alt: Python 3

.. image:: https://api.travis-ci.org/ad-m/taravel.png
     :target: hhttps://travis-ci.org/ad-m/taravel
     :alt: Travis-CI



Celem strony jest pokazanie, jakie informacje są w posiadaniu spółek, a mimo to nie publikują one ich na BIP + wskazanie, czemu te informacje są czy mogą być ważne dla mieszkańców i zachęcenie mieszkańców do interesowania się.

LICENSE: MIT

Settings
------------

Moved to settings_.

.. _settings: http://cookiecutter-django.readthedocs.org/en/latest/settings.html

Basic Commands
--------------

Setting Up Your Users
^^^^^^^^^^^^^^^^^^^^^

To create a **normal user account**, just go to Sign Up and fill out the form. Once you submit it, you'll see a "Verify Your E-mail Address" page. Go to your console to see a simulated email verification message. Copy the link into your browser. Now the user's email should be verified and ready to go.

To create an **superuser account**, use this command::

    $ python manage.py createsuperuser

For convenience, you can keep your normal user logged in on Chrome and your superuser logged in on Firefox (or similar), so that you can see how the site behaves for both kinds of users.

Test coverage
^^^^^^^^^^^^^

To run the tests, check your test coverage, and generate an HTML coverage report::

    $ coverage run manage.py test
    $ coverage html
    $ open htmlcov/index.html

Running tests
~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

  $ pyton manage.py test


Sentry
^^^^^^

Sentry is an error logging aggregator service. You can sign up for a free account at http://getsentry.com or download and host it yourself.
The system is setup with reasonable defaults, including 404 logging and integration with the WSGI application.

You must set the DSN url in production.

It's time to write the code!!!
