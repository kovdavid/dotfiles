#!/usr/bin/python2

import i3
import os

def toggle_split_orientation():
    try:
        with open('/tmp/i3_split_orientation'):
            os.remove('/tmp/i3_split_orientation')
            i3.msg(0, 'split horizontal')
    except IOError:
        i3.msg(0, 'split vertical')
        open('/tmp/i3_split_orientation', 'a').close()

if __name__ == '__main__':
    toggle_split_orientation()
