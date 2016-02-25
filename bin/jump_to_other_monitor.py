#!/usr/bin/python2

import i3

outputs = i3.get_outputs()
workspaces = i3.get_workspaces()


def _connected_output(output):
    return [x for x in outputs if x['name'] == output and x['active']][0]


def _get_current_workspace():
    return [x for x in workspaces if x['focused']][0]


def _get_visible_workspace_on_output(output):
    return [x for x in workspaces if x['output'] == output and x['visible']][0]
def jump_to_other_monitor():
    if not _connected_output('DP1'):
        return

    current_workspace = _get_current_workspace()

    if current_workspace['output'] == 'LVDS1':
        other_workspace = _get_visible_workspace_on_output('DP1')
    else:
        other_workspace = _get_visible_workspace_on_output('LVDS1')

    if other_workspace:
        workspace_num = str(other_workspace['num'])
        i3.workspace(workspace_num)

if __name__ == '__main__':
    jump_to_other_monitor()
