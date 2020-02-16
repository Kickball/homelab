#https://stackoverflow.com/a/11447648/3085144
import os
#https://github.com/xtream1101/humblebundle-downloader/
import humblebundle-downloader as hbd

#https://stackoverflow.com/a/14981125/3085144
from __future__ import print_function
import sys

def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)from __future__ import print_function
import sys

def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

#https://stackoverflow.com/a/11447648/3085144
if !('HBD_LIBRARY_PATH' in os.environ):
   eprint("Error: HBD_LIBRARY_PATH Environment Variable not set")
   quit()
else:
   hbdLibraryPath = os.environ.get('HBD_LIBRARY_PATH')

if !('HBD_COOKIE' in os.environ):
   eprint("Error: HBD_COOKIE Environment Variable not set")
   quit()
else:
   hbdCookie = os.environ.get('HBD_COOKIE')

hbd download --cookie-file hbdCookie --library-path hbdLibraryPath --update
