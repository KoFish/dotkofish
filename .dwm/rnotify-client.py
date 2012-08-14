#!/usr/bin/python2

import subprocess
import socket, sys
import shlex

def accept_connections(s):
    conn, addr = s.accept()
    try:
        data = ""
        d = conn.recv(1024)
        while d:
            data += d 
            d = conn.recv(1024)
    finally:
        conn.close()

    if data:
        try:
            urgency, icon, title, body = shlex.split(data)
            subprocess.call(["notify-send", "-u", urgency, "-c", "IRC", "-i", icon, title, body])
        except ValueError as e:
            print e
        except OSError as e:
            print e

    accept_connections(s)

def main(argv):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind(("localhost", int(argv[1] if len(sys.argv) > 1 else 1234)))
    s.listen(5)
    try:
        accept_connections(s)
    except KeyboardInterrupt as e:
        print(e)
    finally:
        s.close()

if __name__ == '__main__':
    main(sys.argv)
