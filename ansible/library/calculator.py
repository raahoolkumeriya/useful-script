#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2022, codelocked 


import os
from ansible.module_utils.basic import AnsibleModule
__metaclass__ = type


DOCUMENTATION = r'''
---
module: calculator
author:
    - Rahul Kumeriya (@kumeriyaRahul)
'''

EXAMPLE = r'''
'''

RETURN = r'''
# These are possible return values, and in general should other names for return values.
'''

def calculate(mode, x, y):
    if mode == 'add':
        return x + y
    elif mode == 'sub':
        return x - y
    elif mode == 'mul':
        return x * y 
    elif mode == 'div':
        return x / y
    else:
        return x,y

def main():
    module_args = dict(
        mode=dict(type="str", required=True),
        x=dict(type="int", required=True),
        y=dict(type="int", required=True)
        )
    # seed the result dict in the object
    result = dict(
        changed=False,
        message=''
    )
    module = AnsibleModule(
            argument_spec=module_args,
            supports_check_mode=True)
    # if the user is working with this module in only check mode 
    if module.check_mode:
        module.exit_json(**result)

    status = calculate(module.params['mode'], module.params['x'], module.params['y']) 
    # during the execution of the module, if there is an exception 
    if status == list():
        module.fail_json(msg='calculator is stupid to do it.', **result)
    # in the event of a successful module execution
    module.exit_json(msg=status)


if __name__ == '__main__':
    main()

