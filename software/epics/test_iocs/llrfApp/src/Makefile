TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================
USR_CXXFLAGS += -std=c++0x

# =====================================================
# Path to "NON EPICS" External PACKAGES: USER INCLUDES
# ======================================================
USR_INCLUDES = $(addprefix -I,$(BOOST_INCLUDE) $(CPSW_FRAMEWORK_INCLUDE) $(YAML_INCLUDE))
# =====================================================

# ======================================================
#PATH TO "NON EPICS" EXTERNAL PACKAGES: USER LIBRARIES
# ======================================================
cpsw_DIR = $(CPSW_FRAMEWORK_LIB)
yaml-cpp_DIR = $(YAML_LIB)

# =====================================================

# ======================================================
# LINK "NON EPICS" EXTERNAL PACKAGE LIBRARIES STATICALLY
# =======================================================
USR_LIBS_Linux += cpsw yaml-cpp
# ======================================================

#=============================
# Build the IOC application

PROD_IOC = llrf
# llrf.dbd will be created and installed
DBD += llrf.dbd

# llrf.dbd will be made up from these files:
llrf_DBD += base.dbd
llrf_DBD += devIocStats.dbd
llrf_DBD += asSupport.dbd
llrf_DBD += system.dbd
llrf_DBD += asyn.dbd
llrf_DBD += yamlLoader.dbd
llrf_DBD += ycpswasyn.dbd
llrf_DBD += iocAdmin.dbd
llrf_DBD += devSeqCar.dbd

# Include dbd files from all support applications:
#llrf_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
llrf_LIBS += devIocStats
llrf_LIBS += autosave
llrf_LIBS += yamlLoader
llrf_LIBS += ycpswasyn
llrf_LIBS += asyn
llrf_LIBS += seqCar seq pv

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
   l2MpsLN_LIBS += qsrv
   l2MpsLN_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
   l2MpsLN_DBD  += PVAServerRegister.dbd
   l2MpsLN_DBD  += qsrv.dbd
endif

# llrf_registerRecordDeviceDriver.cpp derives from llrf.dbd
llrf_SRCS += llrf_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
llrf_SRCS_DEFAULT += llrfMain.cpp
llrf_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#llrf_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
llrf_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

