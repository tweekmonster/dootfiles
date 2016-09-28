import os
import sys
import site

if len(sys.argv) == 1:
    del os.environ['PYTHONSTARTUP']
    sys.path.append(site.USER_SITE)

    try:
        """Replace python with IPython

        This requires that this interpreter's version has IPython installed in
        the user site.  e.g. pip install --user ipython

        If IPython can be imported, replace the process with IPython instead.
        """
        if 'IPython' in sys.modules:
            raise ImportError('IPython is already imported')

        import IPython

        env = os.environ.copy()
        env['PYTHONPATH'] = site.USER_SITE
        print('Replacing with IPython...')
        os.execve(sys.executable,
                  (os.path.basename(sys.executable), '-m', 'IPython'), env)
    except ImportError:
        """Fallback to the plain REPL."""
        import readline
        import rlcompleter

        readline.parse_and_bind('tab: complete')
