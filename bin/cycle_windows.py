#!/usr/bin/python2

import i3

def cycle_windows():
    num = i3.filter(i3.get_workspaces(), focused=True)[0]['num']
    ws_nodes = i3.filter(num=num)[0]['nodes']
    curr = i3.filter(ws_nodes, focused=True)[0]

    ids = sorted([win['id'] for win in i3.filter(ws_nodes, nodes=[])])

    print "Current: ", curr['id']

    for x in ids:
        print "ID: ", x

    next_idx = (ids.index(curr['id']) + 1) % len(ids)
    next_id = ids[next_idx]

    print "Next: ", next_id

    i3.focus(con_id=next_id)

if __name__ == '__main__':
    cycle_windows()
