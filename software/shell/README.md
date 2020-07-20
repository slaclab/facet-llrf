# Shell scripts

## Description

This directory contains shell scripts for the LLRF application.

## Scripts

### check_dac.sh

This script launches the `check_dac` test application, which is part of the [llrfAmc](https://github.com/slaclab/llrfAmc) driver. It uses the driver version `master` built in the AFS `$PACKAGE_TOP` area.

The script should be run in `cpu-b084-sp19` and it points to AMC carrier installed in `shm-b084-sp19`, slot 6. It uses the `LlrfGen2` YAML description files located in the test IOC `test_iocs` in this repository, and it uses the YAML defaults file `defaults_cw.yaml` part of the same IOC.

#### How to run the script

1. Login `lcls-dev3` and open a bash shell.
2. Clone this repository in AFS space.
3. Login to `cpu-b084-sp19`.
4. Go to the AFS location used in step 2. Then go to `software/shell/`
5. Run the script:
```
$ ./check_dac.sh
```
