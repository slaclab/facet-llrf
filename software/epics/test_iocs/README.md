# LLRF EPICS IOCS

## Description 

This directory contains EPICS IOCS for the LLRF application.

## Sub-directories 

### test_iocs:

This directory contains and EPICS application which uses YCPSWASYN with auto-generation of PV enabled for all registers. So, all registers are expose via PVs.

The application contains 2 IOCs: 

#### sio-b084-rf50

This IOC runs the Gen1 LLRF application: 
```
================================================================================
| BSI: shm-b084-sp19/4/CEN (shm-b084-sp19/4/4)                                 |
BSI Ld  State:  3          (READY)
BSI Ld Status: 0x00000000  (SUCCESS)
  BSI Version: 0x0103 = 1.3
        MAC 0: 08:00:56:00:4e:ee
        MAC 1: 08:00:56:00:4e:ef
        MAC 2: 08:00:56:00:4e:f0
        MAC 3: 08:00:56:00:4e:f1
   DDR status: 0x0003: MemErr: F, MemRdy: T, Eth Link: Up
  Enet uptime:      94276 seconds
  FPGA uptime:      94277 seconds
 FPGA version: 0x00000005
 BL start adx: 0x04000000
     Crate ID: 0x0001
    ATCA slot: 4
   AMC 0 info: Aux: 01 Ser: d8000001478a1570 Type: 07 Ver: C03 BOM: 01 Tag: C03-15
   AMC 2 info: Aux: 01 Ser: 9300000135667170 Type: 07 Ver: C03 BOM: 01 Tag: 02
     GIT hash: dc01254465911467f7afec3b1bfc41382009bc1f
FW bld string: 'Llrf: Vivado v2018.3, rdsrv300 (x86_64), Built Fri 12 Jun 2020 08:48:36 AM PDT by mdewart'
--------------------------------------------------------------------------------
```

installed in `shm-b084-sp19`, slot 4, with the following AMC daughter boards:
```
AMC 0 Device Description :
 Board Mfg Date        : 2017-07-24 00:00:00
 Board Mfg Name        : SLAC
 Board Serial No.      : d8000001478a1570
 Board Part Number     : PC_379_396_16_C03_A01
 Product Mfg Name      : SLAC
 Product Part Number   : PC_379_396_16_C03_A01
 Product Version       : C03
 Product Serial No.    : d8000001478a1570
 Product Asset Tag     : C03-15
 Internal Aux Pwr Ekey : 01
 Internal BOM          : 01
 Internal Type         : 00000007
AMC 2 Device Description :
 Board Mfg Date        : 2017-07-24 00:00:00
 Board Mfg Name        : SLAC
 Board Serial No.      : 9300000135667170
 Board Part Number     : PC_379_396_17_C03_A01
 Product Mfg Name      : SLAC
 Product Part Number   : PC_379_396_17_C03_A01
 Product Version       : C03
 Product Serial No.    : 9300000135667170
 Product Asset Tag     : 02
 Internal Aux Pwr Ekey : 01
 Internal BOM          : 01
 Internal Type         : 00000007
 ```

#### sio-b084-rf51

This IOC runs the Gen2 LLRF application: 
```
================================================================================
| BSI: shm-b084-sp19/6/CEN (shm-b084-sp19/6/4)                                 |
BSI Ld  State:  3          (READY)
BSI Ld Status: 0x00000000  (SUCCESS)
  BSI Version: 0x0103 = 1.3
        MAC 0: 08:00:56:00:4d:96
        MAC 1: 08:00:56:00:4d:97
        MAC 2: 08:00:56:00:4d:98
        MAC 3: 08:00:56:00:4d:99
   DDR status: 0x0003: MemErr: F, MemRdy: T, Eth Link: Up
  Enet uptime:       2343 seconds
  FPGA uptime:       2344 seconds
 FPGA version: 0x00000005
 BL start adx: 0x04000000
     Crate ID: 0x0001
    ATCA slot: 6
   AMC 0 info: Aux: 01 Ser: 2500000147827570 Type: 07 Ver: C03 BOM: 01 Tag: C03-13
   AMC 2 info: Aux: 01 Ser: a800000147abe470 Type: 0b Ver: C00 BOM: 03 Tag: A01_01
     GIT hash: 7b0f1fd02ff2ff761783bfb92ffc225ac4bb2ea1
FW bld string: 'LlrfGen2: Vivado v2019.1, rdsrv301 (x86_64), Built Wed 10 Jun 2020 01:45:12 PM PDT by mdewart'
--------------------------------------------------------------------------------
```

installed in `shm-b084-sp19`, slot 6, with the following AMC daughter boards:
```
AMC 0 Device Description :
 Board Mfg Date        : 2017-07-24 00:00:00
 Board Mfg Name        : SLAC
 Board Serial No.      : 2500000147827570
 Board Part Number     : PC_379_396_16_C03_A01
 Product Mfg Name      : SLAC
 Product Part Number   : PC_379_396_16_C03_A01
 Product Version       : C03
 Product Serial No.    : 2500000147827570
 Product Asset Tag     : C03-13
 Internal Aux Pwr Ekey : 01
 Internal BOM          : 01
 Internal Type         : 00000007
AMC 2 Device Description :
 Board Mfg Date        : 2019-06-26 00:00:00
 Board Mfg Name        : SLAC
 Board Serial No.      : a800000147abe470
 Board Part Number     : PC_379_156_06_C00_A01
 Product Mfg Name      : SLAC
 Product Part Number   : PC_379_156_06_C00_A01
 Product Version       : C00
 Product Serial No.    : a800000147abe470
 Product Asset Tag     : A01_01
 Internal Aux Pwr Ekey : 01
 Internal BOM          : 03
 Internal Type         : 0000000b
 ```

## How to build the application

1. Log in to `lcls-dev3`, and open a bash shell.
2. Source the EPICS 7.0.3.1-1.0 environment:
```
$ . $EPICS_SETUP/epicsenv-7.0.3.1-1.0.bash
```
3. Clone this repository.
4. Go to this directory and build the application:
```
$ make
```

## How to run the IOCs

1. First build the application as described above.
2. Login to `cpu-b084-sp19`:
``` 
$ ssh laci@cpu-b084-sp19
```
3. Go to the directory where you built the application (let's call it `<TOP>`):
```
$ cd <TOP>
```
4. Go to the top directory of the IOC you want to run (<IOC> can be `sioc-b084-rf50` of `sioc-b084-rf51`):
```
$ cd iocBoot/<IOC>
```
5. Start the IOC:
```
$ ../../bin/linuxRT-x86_64/llrf st.cmd
```

If you want to keep you IOC running in the background, you can start a screen session once you are logged in `cpu-b084-sp19`, and the run steps 3-5 inside the screen session.
