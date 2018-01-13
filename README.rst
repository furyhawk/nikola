A Docker Image for Nikola
=========================

This is a `Docker`_ image for the `Nikola`_ static site generator.  It
is based on `Alpine Linux`_ and uses the latest version of Nikola with
Python 3.  All Nikola "extras" are available.  Additional requirements
for any "extras" that you use need to be installed manually.  This can
be done by deriving a custom Docker image ``FROM`` this one.
All languages supported by Nikola can be used.

You can pull the most recent pre-built image directly from the GitLab
Container Registry with:

::

   docker pull registry.gitlab.com/paddy-hack/nikola

Please note that the image does not have a default command set.  Also
note that the image uses ``/bin/sh`` rather than ``/bin/bash``.


Image Versions
--------------

The above command will pull the ``latest`` image that passed the build
tests.  Images tagged with the upstream version used in the build are
available as well.  A ``registry.gitlab.com/paddy-hack/nikola:7.8.0``
image was built using Nikola version 7.8.0.  Have a look at the
`container registry`_ to see what's available.


Using the Image
---------------

Assuming your Nikola site lives in the current directory, you can use
something like

::

   docker run --rm -it -v $PWD:/site -w /site -u $(id -u):$(id -g) \
       registry.gitlab.com/paddy-hack/nikola /bin/sh

to start a container.  Your site will be volume mounted on ``/site``,
which is also the working directory inside the container.  The ``-u``
option will cause all files created by ``nikola`` to be owned by the
user and group IDs that you have *outside* the container.  This makes
life easier if you want to modify or remove files after you have left
the container.

Once in the container, you can use the regular ``nikola`` commands to
maintain your site interactively.  Of course, you can also start up a
container for a one-off ``nikola`` command.  For example

::

   docker run --rm -v $PWD:/site -w /site -u $(id -u):$(id -g) \
       registry.gitlab.com/paddy-hack/nikola nikola check -l

would check your site for dangling links.


Creating a Nikola Site
----------------------

Don't have a site yet?  No problem.  You can run ``nikola init`` in an
interactive container.  You can also run a one-off, like so

::

   docker run --rm -it -v $PWD:/site -w /site -u $(id -u):$(id -g) \
       registry.gitlab.com/paddy-hack/nikola nikola init .

If you prefer to skip all the questions, pass the ``--quiet`` option
to the ``nikola init`` command and edit the ``conf.py`` manually once
the command has finished.


Serving Your Site Locally
-------------------------

Want to proofread your site?  No problem!  You can use ``nikola``'s
``serve`` command for this.  It serves your site on port 8000 by
default but you have to expose that container port in order to make it
accessible from the outside.  That goes like this (note the ``-p``
option)

::

   docker run --rm -v $PWD:/site -w /site -u $(id -u):$(id -g) \
       -p 8888:8000 registry.gitlab.com/paddy-hack/nikola nikola serve

Now you can browse your site at ``http://localhost:8888/``.

Use ``Ctrl+C`` to shut down the container process.


.. _Alpine Linux: https://alpinelinux.org/
.. _Docker: https://www.docker.com/
.. _Docker Hub: https://hub.docker.com/
.. _Nikola: https://getnikola.com/
.. _container registry: https://gitlab.com/paddy-hack/nikola/container_registry
