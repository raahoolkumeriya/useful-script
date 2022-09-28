#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2022, codelocked 


import os
from ansible.module_utils.basic import AnsibleModule
__metaclass__ = type


DOCUMENTATION = r'''
---
module: pmon_status
short_description: Check pmon process from target server.
description:
     - The module takes the instance name as string parameter.
version_added: "1.0.0"
options:
  instance:
    description: This is instance name to check related pmon process details.
    type: str
    required: true
author:
    - Rahul Kumeriya (@kumeriyaRahul)
'''

EXAMPLE = r'''
# Pass the instance name
- name: check pmon process for instance
  pmon_status:
    instance: ORCLPDB
# fail the module
- name: missing pmon process for instance
  pmon_status:
    instance: 
'''

RETURN = r'''
# These are possible return values, and in general should other names for return values.
"msg": [
            {
                "CMD": "ora_pmon_SBCDB",
                "TIME": "00:02:11",
                "TTY": "?",
                "effective_user_id": "54321",
                "parent_process_id": "85186",
                "process_id": "288628",
                "processor_utilization": "0",
                "start_time": "Sep27"
            }
        ]
'''

def map_headers(text: str) -> dict:
    header = ['effective_user_id','process_id','parent_process_id','processor_utilization','start_time','TTY','TIME','CMD']
    return dict(zip(header,text.split()))

def check_pmon(instance:str) -> list:
    cmd = f'ps -ef|grep pmon|grep -v grep|grep -v python|grep -i {instance}'
    a=os.popen(cmd).read()

    final_result = list() 
    for i in  [ l for k,l in enumerate(a.split('\n')) if l!='']:
        final_result.append(map_headers(i))
    return final_result

def main():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        instance=dict(type="str", required=True)
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
    instance = os.path.expanduser(module.params['instance'])
    status = check_pmon(instance)
    # during the execution of the module, if there is an exception 
    if status == []:
        module.fail_json(msg='PMON process is NOT running on host server.', **result)
    # in the event of a successful module execution
    module.exit_json(msg=status)

if __name__ == '__main__':
    main()
