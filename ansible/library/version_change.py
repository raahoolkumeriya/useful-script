#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2022, codelocked 


import os
from ansible.module_utils.basic import AnsibleModule
__metaclass__ = type


DOCUMENTATION = r'''
---
module: version_change
author:
    - Rahul Kumeriya (@kumeriyaRahul)
'''

EXAMPLE = r'''
'''

RETURN = r'''
# These are possible return values, and in general should other names for return values.
'''

def main():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        version_no=dict(default=True, type="str"),
        version_name=dict(default=True, type="str"),
        unchanged_value=dict(default=True, type="str")
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
    module.params.update({"version_name":"After"})
    # bump minor and patch version
    mylist = module.params["version_no"].split('.')
    mylist[2] = str(int(mylist[2]) + 2)
    mylist[1] = str(int(mylist[1]) + 1)
    mystr= '.'.join(mylist)
    module.params.update({"version_no": mystr})

    module.exit_json(changed=True, meta=module.params)


if __name__ == '__main__':
    main()
