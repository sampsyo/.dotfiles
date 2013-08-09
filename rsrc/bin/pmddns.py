#!/usr/bin/env python3

"""The poor man's dynamic DNS.
"""
import requests
import sys
import subprocess
import os

IP_FILE = os.path.expanduser('~/.curip')

def update(ip, host, path):
    proc = subprocess.Popen(['ssh', host, 'cat > ' + path],
                            stdin=subprocess.PIPE)
    proc.communicate(ip.encode('utf8'))

def main(host, path):
    cur_ip = requests.get("http://icanhazip.com").text.strip()
    if os.path.exists(IP_FILE):
        with open(IP_FILE) as f:
            stored_ip = f.read().strip()
        if stored_ip == cur_ip:
            print('ip not changed')
            return

    print('updating ip to', cur_ip)
    update(cur_ip, host, path)
    with open(IP_FILE, 'w') as f:
        f.write(cur_ip)

if __name__ == '__main__':
    main(*sys.argv[1:])
