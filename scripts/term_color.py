#!/usr/bin/python2
import os,sys,re,hashlib

def help():
    return """\
TERM COLOR

 Examples:
    > python term_color.py run #ff0000 - ssh localhost

This is a pretty simple script that is primarly optimized to work with rxvt and
xterm compatible terminals on linux. It works by outputing escape- sequences
that changes the behaviour of the terminal, the same system that is used to show
colored text.

The supported commands are:
  run [<color> -] <cmd>  - Changes the background color to color (if a hex-
                           color) and runs the command, resets the color to the
                           previous one when the command is finished. If no
                           color is specified the command is used to generate a
                           color according to the same rules as the set
                           function.
  set <string>           - Sets the terminal background to a hexcolor if string
                           starts with a hash, otherwise the string is hashed,
                           using md5, and the 6 first characters in the hex-hash
                           is interpreted as a color.
  get                    - Returns a hex-color representation of the current
                           background color.

  Anything but these commands will output a reset sequence (that only works in
  xterm as far as I know.

  IMPORTANT NOTE: This script requires python 2 above version 2.5.
"""
             

def get_current():
    #  This function locks up the terminal if running in Python 3.
    import termios, tty
    fd = sys.stdin.fileno()
    settings = termios.tcgetattr(fd)
    tty.setraw(fd)
    sys.stdout.write('\033]11;?\a')
    resp = c = ''
    try:
        while c != '\a':
            resp += c
            c = sys.stdin.read(1)
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, settings)
    return '#'+''.join(c[0:2] for c in resp.split(':',1)[1].split('/'))

def reset():
    return '\033]111\a'

def gen_color(string):
    """Generate a color based on the string by md5 hashing it and using a part
       of the hash hex representation as a color. Also darkens the color to
       avoid very bright ones."""
    hash = hashlib.md5(''.join((string)).encode()).hexdigest()
    components = map(''.join,list(zip(*[iter(hash)]*2))[:3])
    return '#' + ''.join('%02x'%(int(x, 16)*0.35) for x in components)

def set_color(string):
    """Set the color specified by string or generate a color and use that if
       string doesn't start with #."""
    color = string if string.startswith('#') else gen_color(string)
    return '\033]11;%s\a' % color

def run(string):
    curr_color = get_current()
    try:
        col, cmd = (x.strip() for x in string.split('-', 1))
        if not re.match(r'^#[0-9a-fA-F]{6}$', col):
            raise ValueError()
    except ValueError:
        col, cmd = gen_color(string), string
    sys.stdout.write(set_color(col))
    sys.stdout.flush()
    try:
        os.system(cmd)
    finally:
        sys.stdout.write(set_color(curr_color))
        sys.stdout.flush()
    return ''

def main():
    command,args = (sys.argv[1], sys.argv[2:]) if len(sys.argv) >= 2 else ('get', [])
    f = {'set': lambda: set_color(' '.join(args)),
         'get': lambda: get_current() + '\n',
         'run': lambda: run(' '.join(args)),
         'help': lambda: help()}.get(command, lambda: reset())
    sys.stdout.write(f())
    sys.stdout.flush()

if __name__ == '__main__':
    main()
