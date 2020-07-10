#!/usr/bin/env sh

top=..

${top}/cpp/driver//buildroot-2019.08-x86_64/bin/check_dac \
    -a 10.0.1.106 \
    -Y ${top}/epics/test_iocs/firmware/LlrfGen2/yaml/000TopLevel.yaml \
    -d ${top}/epics/test_iocs/firmware/LlrfGen2/yaml/config/defaults_cw.yaml
