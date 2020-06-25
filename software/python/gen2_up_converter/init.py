#!/usr/bin/env python

import time
import epics

def check_if_zero(array):
    ret = True
    for x in array:
        if x != 0:
            ret = False

    return ret

def check_if_not_zero(array):
    ret = True
    for x in array:
        if x == 0:
            ret = False

    return ret

def poll_and_read_pv(pv_name):
    epics.caput('{}.PROC'.format(pv_name), 1)
    return epics.caget(pv_name)

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

    # Emulate pyrogue's AppTop.Init()
    print('Running initialization code...')

    retry_max = 8
    for i in range(retry_max):
        print('Executing init code, try {}...'.format(i))
        epics.caput('{}:AT:ATJ1:JR:ResetGTs:St'.format(epics_prefix), 1)
        epics.caput('{}:AT:ATJ1:JT:ResetGTs:St'.format(epics_prefix), 1)
        epics.caput('{}:AT:AC:AmcG2UC:LMK:PwrDwnLmkChip:Ex'.format(epics_prefix), 1)
        epics.caput('{}:AT:AC:AmcG2UC:LMK:PwrDwnSysRef:Ex'.format(epics_prefix), 1)
        epics.caput('{}:AT:AC:AmcG2UC:LMK:PwrUpLmkChip:Ex'.format(epics_prefix), 1)
        time.sleep(1.000)
        epics.caput('{}:AT:AC:AmcG2UC:LMK:PwrUpSysRef:Ex'.format(epics_prefix), 1)
        time.sleep(0.250)
        rx_enable = epics.caget('{}:AT:ATJ1:JR:Enable:Rd'.format(epics_prefix))
        tx_enable = epics.caget('{}:AT:ATJ1:JT:Enable:Rd'.format(epics_prefix))
        epics.caput('{}:AT:ATJ1:JR:Enable:St'.format(epics_prefix), 0)
        epics.caput('{}:AT:ATJ1:JR:ResetGTs:St'.format(epics_prefix),0)
        epics.caput('{}:AT:ATJ1:JT:Enable:St'.format(epics_prefix), 0)
        epics.caput('{}:AT:ATJ1:JT:ResetGTs:St'.format(epics_prefix),0)
        time.sleep(0.250)
        epics.caput('{}:AT:ATJ1:JT:ClearTxStatus:Ex'.format(epics_prefix), 1)
        epics.caput('{}:AT:ATJ1:JT:Enable:St'.format(epics_prefix), tx_enable)
        epics.caput('{}:AT:ATJ1:JR:ClearRxErrors:Ex'.format(epics_prefix), 1)
        epics.caput('{}:AT:ATJ1:JR:Enable:St'.format(epics_prefix), rx_enable)

        
        epics.caput('{}:AT:AC:AmcG2UC:Dac38J84:NcoSync:Ex'.format(epics_prefix), 1)

        link_locked = True

        jesdrx1_data_valid = poll_and_read_pv('{}:AT:ATJ1:JR:DataValid:Rd'.format(epics_prefix))
        jesdrx1_pos_err    = poll_and_read_pv('{}:AT:ATJ1:JR:PositionErr:Rd'.format(epics_prefix))
        jesdrx1_align_err  = poll_and_read_pv('{}:AT:ATJ1:JR:AlignErr:Rd'.format(epics_prefix))

        if not (check_if_not_zero(jesdrx1_data_valid) and check_if_zero(jesdrx1_pos_err) and check_if_zero(jesdrx1_align_err) ):
            print('Link not locked:')
            print '/mmio/AppTop/AppTopJesd1/JesdRx/DataValid   = ',
            for x in jesdrx1_data_valid:
                print "{} ".format(x),
            print('')
            print '/mmio/AppTop/AppTopJesd1/JesdRx/PositionErr = ',
            for x in jesdrx1_pos_err:
                print "{} ".format(x),
            print('')
            print  '/mmio/AppTop/AppTopJesd1/JesdRx/AlignErr    = ',
            for x in jesdrx1_align_err:
                print "{} ".format(x),
            print('')
            link_locked = False

        jesdtx1_data_valid = poll_and_read_pv('{}:AT:ATJ1:JT:DataValid:Rd'.format(epics_prefix))

        if not check_if_not_zero(jesdtx1_data_valid):
            print('Link not locked:')
            print '/mmio/AppTop/AppTopJesd1/JesdTx/DataValid   = ',
            for x in jesdtx1_data_valid:
                print "{} ".format(x),
            print('')
            link_locked = False


        sysref_period_min = poll_and_read_pv('{}:AT:ATJ1:JT:SysRefPeriodmin:Rd'.format(epics_prefix))
        sysref_period_max = poll_and_read_pv('{}:AT:ATJ1:JT:SysRefPeriodmax:Rd'.format(epics_prefix))

        if sysref_period_min != sysref_period_max:
            print('AppTopJesd1/JesdTx link not locked: SysRefPeriodmin = {}, SysRefPeriodmax = {}'.format(sysref_period_min, sysref_period_max))
            link_locked = False

        sysref_period_min = poll_and_read_pv('{}:AT:ATJ1:JR:SysRefPeriodmin:Rd'.format(epics_prefix))
        sysref_period_max = poll_and_read_pv('{}:AT:ATJ1:JR:SysRefPeriodmax:Rd'.format(epics_prefix))

        if sysref_period_min != sysref_period_max:
            print('AppTopJesd1/JesdRx link not locked: SysRefPeriodmin = {}, SysRefPeriodmax = {}'.format(sysref_period_min, sysref_period_max))
            link_locked = False

        if link_locked:
            break

    print('')
    if i == retry_max - 1:
        print('ERROR: Could not init hardware after {retry_max} retries. Aborting...'.format(retry_max))
    else:
        print('Done!')
    print('')

    jesdrx1_data_valid = poll_and_read_pv('{}:AT:ATJ1:JR:DataValid:Rd'.format(epics_prefix))
    print '/mmio/AppTop/AppTopJesd1/JesdRx/DataValid = ',
    for x in jesdrx1_data_valid:
        print "{} ".format(x),
    print('')
    jesdtx1_data_valid = poll_and_read_pv('{}:AT:ATJ1:JT:DataValid:Rd'.format(epics_prefix))
    print '/mmio/AppTop/AppTopJesd1/JesdTx/DataValid = ',
    for x in jesdtx1_data_valid:
        print "{} ".format(x),
    print('')
    print('==============================')
    print('')
