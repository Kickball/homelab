from __future__ import print_function
import sys
import os
import subprocess

##https://stackoverflow.com/a/14981125/3085144
def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

#https://stackoverflow.com/a/11447648/3085144
if ('HBD_LIBRARY_PATH' not in os.environ):
   eprint("Error: HBD_LIBRARY_PATH Environment Variable not set")
   quit()
else:
   hbdLibraryPath = os.environ.get('HBD_LIBRARY_PATH')

if ('HBD_COOKIE' not in os.environ):
   eprint("Error: HBD_COOKIE Environment Variable not set")
   quit()
else:
   hbdCookie = os.environ.get('HBD_COOKIE')

#https://github.com/xtream1101/humblebundle-downloader/
#https://stackoverflow.com/a/40319875/3085144
subprocess.run(["hbd","download","--cookie-file",hbdCookie,"--library-path",hbdLibraryPath,"--update"], stdout=subprocess.PIPE)