#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2022, codelocked 


import os
from ansible.module_utils.basic import AnsibleModule
__metaclass__ = type


DOCUMENTATION = r'''
---
module: hello_world
author:
    - Rahul Kumeriya (@kumeriyaRahul)
'''

EXAMPLE = r'''
'''

RETURN = r'''
# These are possible return values, and in general should other names for return values.
'''

def main():
    module = AnsibleModule(argument_spec={})
    theReturnValue = {"hello": "world"}
    module.exit_json(changed=False, meta=theReturnValue)

if __name__ == '__main__':
    main()

