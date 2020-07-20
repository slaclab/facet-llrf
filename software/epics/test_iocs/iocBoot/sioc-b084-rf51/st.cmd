#!../../bin/linuxRT-x86_64/llrf

#- You may have to change llrf to something else
#- everywhere it appears in this file

< envPaths
# ===========================================
#            ENVIRONMENT VARIABLES
# ===========================================

# IOC name
epicsEnvSet("IOC_NAME", "SIOC:B084:RF51")

# PV prefix
epicsEnvSet("YCPSWASYN_PREFIX", "LLRFGEN2")

# CPSW port name
epicsEnvSet("YCPSWASYN_PORT","YCPSWASYN")

# Location to download the YAML file from the FPGA
epicsEnvSet("YAML_DIR","firmware/LlrfGen2/yaml")

# YAML file
epicsEnvSet("YAML","${YAML_DIR}/000TopLevel.yaml")

# Defaults yaml file
epicsEnvSet("DEFAULTS_FILE", "${YAML_DIR}/config/defaults_cw.yaml")

# FPGA IP address
epicsEnvSet("FPGA_IP","10.0.1.106")

# llrfAmcAsyn port name
epicsEnvSet("LLRFAMCASYN_PORT","LLRFAMCASYN")

# ======================================
# Start from TOP
# ======================================
cd ${TOP}

# ===========================================
#               DBD LOADING
# ===========================================
## Register all support components
dbLoadDatabase("dbd/llrf.dbd",0,0)
llrf_registerRecordDeviceDriver(pdbbase) 

# ==========================================
# Create the CPSW root using the yamlLoader
# ==========================================
cpswLoadYamlFile("${YAML}", "NetIODev", "", "${FPGA_IP}")

# ==========================================
# Load application specific configurations
# ==========================================
# Load the defautl configuration
cpswLoadConfigFile("${DEFAULTS_FILE}", "mmio")

# ===========================================
#              DRIVER SETUP
# ===========================================

# Set llrfAmc log level (0: Debug, 1: Warning, 2: Error (default), 3: None)
#LlrfAmcAsynSetLogLevel(2)

## Configure the llrfAmcAsyn driver
# LlrfAmcAsynConfig(
#    Port Name)     # The name given to this port driver
LlrfAmcAsynConfig("${LLRFAMCASYN_PORT}")

# Set the location of the YCPSWASYN map files
YCPSWASYNSetMapFilePath("firmware/maps")

# Set the maximum lenght of PV name to 100 chars
YCPSWASYNSetPvMaxNameLen(100)

## Configure the YCPSWASYN driver
# YCPSWASYNConfig(
#    Port Name,                 # The name given to this port driver
#    Root Path                  # OPTIONAL: Root path to start the generation. If empty, the Yaml root will be used
#    Record name Prefix,        # Record name prefix
#    DB Autogeneration mode,    # Set autogeneration of records. 0: disabled, 1: Enable usig maps, 2: Enabled using hash names.
#    Load dictionary)           # Dictionary file path with registers to load. An empty string will disable this function
YCPSWASYNConfig("${YCPSWASYN_PORT}", "", "${YCPSWASYN_PREFIX}", "1", "")

# ===========================================
#               ASYN MASKS
# ===========================================
asynSetTraceMask("${YCPSWASYN_PORT}", -1, 0x01)
asynSetTraceMask("${LLRFAMCASYN_PORT}", -1, 0x09)

# ===========================================
#               DB LOADING
# ===========================================
# llrfAmcAsyn database
dbLoadRecords("db/llrfAmcAsyn.db", "P=${YCPSWASYN_PREFIX},PORT=${LLRFAMCASYN_PORT}")

# **********************************************************************
# **** Load iocAdmin databases to support IOC Health and monitoring ****
dbLoadRecords("db/iocAdminSoft.db","IOC=${IOC_NAME}")
dbLoadRecords("db/iocAdminScanMon.db","IOC=${IOC_NAME}")

# The following database is a result of a python parser
# which looks at RELEASE_SITE and RELEASE to discover
# versions of software your IOC is referencing
# The python parser is part of iocAdmin
dbLoadRecords("db/iocRelease.db","IOC=${IOC}")

# *******************************************
# **** Load database for autosave status ****
dbLoadRecords("db/save_restoreStatus.db", "P=${YCPSWASYN_PREFIX}:")

# Load the YCPSWASYN database to save and load CPSW configuration files
dbLoadRecords("db/saveLoadConfig.db", "P=${YCPSWASYN_PREFIX},PORT=${YCPSWASYN_PORT}")

# ===========================================
#           SETUP AUTOSAVE/RESTORE
# ===========================================

# If all PVs don't connect continue anyway
#save_restoreSet_IncompleteSetsOk(1)

# created save/restore backup files with date string
# useful for recovery.
#save_restoreSet_DatedBackupFiles(1)

# Where to find the list of PVs to save
# Where "/data" is an NFS mount point setup when linuxRT target
# boots up.
#set_requestfile_path("${IOC_DATA}/${IOC}/autosave-req")
#set_requestfile_path("${TOP}/iocBoot/common")

# Where to write the save files that will be used to restore
#set_savefile_path("${IOC_DATA}/${IOC}/autosave")

# Prefix that is use to update save/restore status database
# records
#save_restoreSet_UseStatusPVs(1)
#save_restoreSet_status_prefix("${L2MPS_PREFIX}:")

## Restore datasets
#set_pass0_restoreFile("info_positions.sav")
#set_pass0_restoreFile("info_settings.sav")

# ===========================================
#          CHANNEL ACESS SECURITY
# ===========================================
# This is required if you use caPutLog.
# Set access security filea
# Load common LCLS Access Configuration File
< ${ACF_INIT}

# ===========================================
#               IOC INIT
# ===========================================
iocInit()

# ===========================================
#           AUTOSAVE TASKS
# ===========================================

# Wait before building autosave files
#epicsThreadSleep(1)

# Generate the autosave PV list
# Note we need change directory to
# where we are saving the restore
# request file, and then we go back
# ${TOP}.
#cd ${IOC_DATA}/${IOC}/autosave-req
#makeAutosaveFiles()
#cd ${TOP}

# Start the save_restore task
# save changes on change, but no faster
# than every 5 seconds.
# Note: the last arg cannot be set to 0
#create_monitor_set("info_positions.req", 5 )
#create_monitor_set("info_settings.req" , 5 )

# Print the registers /mmio/AppTop/AppCore/Sysgen/LlrfDemod/amp
dbgf LLRFGEN2:AT:AC:SG:RFDEM:amp:Rd
