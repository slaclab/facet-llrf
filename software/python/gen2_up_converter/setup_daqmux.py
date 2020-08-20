#!/usr/bin/env python

import time
import epics

if __name__ == "__main__":
    epics_prefix = 'LLRFGEN2'
    defaults_file = '../../epics/test_iocs/firmware/LlrfGen2/yaml/config/defaults.yaml'

    print('Using EPICS prefix: "{}"...'.format(epics_prefix))

    # Read firmware inforamtion
    buildstamp   = epics.caget('{}:AC:AV:BuildStamp:Rd'.format(epics_prefix), as_string=True)
    fpga_version = epics.caget('{}:AC:AV:FpgaVersion:Rd'.format(epics_prefix))
    up_time_cnt  = epics.caget('{}:AC:AV:UpTimeCnt:Rd'.format(epics_prefix))

    git_hash = epics.caget('{}:AC:AV:GitHash:Rd'.format(epics_prefix))
    git_hash_str = ''
    for x in git_hash:
        git_hash_str = '{:02x}{}'.format(x, git_hash_str)
    git_hash_str = '0x{}'.format(git_hash_str)

    print('Firmware information:')
    print('==============================')
    print('Buildstamp      : {}'.format(buildstamp))
    print('FPGA version    : {}'.format(fpga_version))
    print('Git hash        : {}'.format(git_hash_str))
    print('Up time counter : {}'.format(up_time_cnt))
    print('==============================')
    print('')

    # Setting up timing
    epics.caput('{}:AC:AS56040:OutputConfig1:St'.format(epics_prefix), "BP_TIMING_IN")
    epics.caput('{}:AC:ACT:TFR:ClkSel:St'.format(epics_prefix), 0)

    # Setting up the Bsa buffers
    epics.caput('{}:AC:ACBsa:BWE0:WEB:StartAddr:St'.format(epics_prefix),  [0x00000000, 0x10000000, 0x20000000, 0x30000000])
    epics.caput('{}:AC:ACBsa:BWE0:WEB:EndAddr:St '.format(epics_prefix),   [0x00004000, 0x10004000, 0x20004000, 0x30004000])
    epics.caput('{}:AC:ACBsa:BWE0:WEB:Initialize:Ex'.format(epics_prefix), 1)
    epics.caput('{}:AC:ACBsa:BWE1:WEB:StartAddr:St'.format(epics_prefix),  [0x40000000, 0x50000000, 0x60000000, 0x70000000])
    epics.caput('{}:AC:ACBsa:BWE1:WEB:EndAddr:St '.format(epics_prefix),   [0x40004000, 0x50004000, 0x60004000, 0x70004000])
    epics.caput('{}:AC:ACBsa:BWE1:WEB:Initialize:Ex'.format(epics_prefix), 1)

    # Setting up DaqMux
    epics.caput('{}:AT:DM0:DataBufferSize:St'.format(epics_prefix), 0x1000)
    epics.caput('{}:AT:DM0:InputMuxSel:St'.format(epics_prefix), [2, 3, 4, 5 ])
    epics.caput('{}:AT:DM0:ClearTrigStatus:Ex '.format(epics_prefix), 1)
    epics.caput('{}:AT:DM1:DataBufferSize:St'.format(epics_prefix), 0x1000)
    epics.caput('{}:AT:DM1:InputMuxSel:St '.format(epics_prefix), [0, 5, 11, 9])
    epics.caput('{}:AT:DM1:ClearTrigStatus:Ex '.format(epics_prefix), 1)

