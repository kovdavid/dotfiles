#!/usr/bin/python2

import i3
import os

outputs = i3.get_outputs()
workspaces = i3.get_workspaces()

output1 = os.environ['PRIMARY_MONITOR_OUTPUT']
output2 = os.environ['SECONDARY_MONITOR_OUTPUT']

def _connected_output(output):
    return [x for x in outputs if x['name'] == output and x['active']][0]


def _get_current_workspace():
    return [x for x in workspaces if x['focused']][0]


def _get_visible_workspace_on_output(output):
    return [x for x in workspaces if x['output'] == output and x['visible']][0]
def jump_to_other_monitor():
    if not _connected_output(output2):
        return

    current_workspace = _get_current_workspace()

    if current_workspace['output'] == output1:
        other_workspace = _get_visible_workspace_on_output(output2)
    else:
        other_workspace = _get_visible_workspace_on_output(output1)

    if other_workspace:
        workspace_num = str(other_workspace['num'])
        i3.msg(0, 'workspace number %s' % workspace_num)

if __name__ == '__main__':
    jump_to_other_monitor()
