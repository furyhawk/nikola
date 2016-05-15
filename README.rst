A Docker Image for Nikola
=========================

This is a `Docker`_ image for the `Nikola`_ static site generator.  It
is based on `Alpine Linux`_ and uses the latest version of Nikola with
Python 3.  The Nikola "extras" are available.  All languages supported
by Nikola can be used.

You can pull the most recent pre-built image directly from the `Docker
Hub`_ with:

::
   docker pull paddyhack/nikola

Please note that the image does not have a default command set.  Also
note that the image uses ``/bin/sh`` rather than ``/bin/bash``.


Using the Image
---------------

Assuming your Nikola site lives in the current directory, you can use
something like

::
   docker run --rm -it -v $PWD:/site -w /site -u $(id -u):$(id -g) \
       paddyhack/nikola /bin/sh

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
   docker run --rm -it -v $PWD:/site -w /site -u $(id -u):$(id -g) \
       paddyhack/nikola nikola check -l

would check your site for dangling links.


.. _Alpine Linux: https://alpinelinux.org/
.. _Docker: https://www.docker.com/
.. _Docker Hub: https://hub.docker.com/
.. _Nikola: https://getnikola.com/
