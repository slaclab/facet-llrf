#ifndef _DAC38J84_H_
#define _DAC38J84_H_

#include <string>
#include <unistd.h>
#include <cpsw_api_user.h>

#include "helpers.h"

class Dac38J84
{
public:
    Dac38J84(Path r);

    void init();
    void initDac();
    void ncoSync();
    void clearAlarms();

    bool isLocked(bool verbose = false);

private:
    static const std::string ModuleName;
    static const std::size_t MaxNumLanes;

    Path        root;
    ScalVal     enableTxReg;
    Command     clearAlarmsCmd;
    Command     ncoSyncCmd;
    Command     initDacCmd;
    ScalVal     dacReg;
    ScalVal_RO  linkErrCntReg;
    ScalVal_RO  readFifoEmptyReg;
    ScalVal_RO  readFifoUnderflowReg;
    ScalVal_RO  readFifoFullReg;
    ScalVal_RO  readFifoOverflowReg;
    ScalVal_RO  dispErrReg;
    ScalVal_RO  notitableErrReg;
    ScalVal_RO  codeSyncErrReg;
    ScalVal_RO  firstDataMatchErrReg;
    ScalVal_RO  elasticBuffOverflowReg;
    ScalVal_RO  linkConfigErrReg;
    ScalVal_RO  frameAlignErrReg;
    ScalVal_RO  multiFrameAlignErrReg;
    std::size_t numLanes;
};

#endif
