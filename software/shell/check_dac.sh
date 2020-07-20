#!/usr/bin/env sh

top=..
llrfamc_top=/afs/slac/g/lcls/package/llrfAmc
llrfamc_version=master

${llrfamc_top}/${llrfamc_version}/buildroot-2019.08-x86_64/bin/check_dac \
    -a 10.0.1.106 \
    -Y ${top}/epics/test_iocs/firmware/LlrfGen2/yaml/000TopLevel.yaml \
    -d ${top}/epics/test_iocs/firmware/LlrfGen2/yaml/config/defaults_cw.yaml
