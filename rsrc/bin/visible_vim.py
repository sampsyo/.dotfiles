#!/usr/bin/env python3
import subprocess


def call_lines(cmd):
    output = subprocess.check_output(cmd)
    for line in output.decode('utf8', 'ignore').split('\n'):
        if line:
            yield line


def cur_desktop():
    for line in call_lines(['wmctrl', '-d']):
        fields = line.split()
        if fields[1] == '*':
            return fields[0]


def windows_on_desktop(desktop):
    for line in call_lines(['wmctrl', '-l']):
        fields = line.split(None, 3)
        if fields[1] == desktop:
            yield fields[0], fields[2], fields[3]


def vim_servers():
    return call_lines(['vim', '--serverlist'])


def window_is_vim(window_title, server_name):
    return window_title.endswith(' - ' + server_name)


def vims_on_cur_desktop():
    servers = list(vim_servers())
    for addr, host, title in windows_on_desktop(cur_desktop()):
        for server in servers:
            if window_is_vim(title, server):
                yield server


def visible_vim():
    vims = vims_on_cur_desktop()
    try:
        print(next(vims))
    except StopIteration:
        pass


if __name__ == '__main__':
    visible_vim()
