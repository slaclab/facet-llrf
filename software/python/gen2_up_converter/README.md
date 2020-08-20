# Python scrips

## Description 

This directory contains scripts with the Gen2 up converter board.

## Scripts 

### init.py

This scripts initialize the Gen2 up converter board. It requires the `sioc-b084-rf01` IOC to be up an running. The scripts then uses `pyepics` to initialize the board via PVs.

#### How to run the script

1. Make sure `sioc-b084-rf51` is running.
2. Login `lcls-dev3` and open a bash shell.
3. Clone this repository.
4. Go to this directory.
5. Run the script:
```
$ ./init.py
```

### init_v2.py

Similar to `init.py` but with a different sequence of operations.

### plot_b1_l1.py

This script reads and plots the second channel of the second DaqMux.

### setup_daqmux.py

This script sets up the DaqMux.
