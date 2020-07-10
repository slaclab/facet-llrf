#ifndef _JESDRX_H_
#define _JESDRX_H_

#include <algorithm> 
#include <cpsw_api_user.h>

#include "helpers.h"

class JesdRx
{
public:
    JesdRx(Path r);

    void     setEnable(uint32_t enable) const;
    uint32_t getEnable() const;
    void     clearErrors() const;
    void     resetGTs() const;
    bool     isLocked(bool verbose = false) const;

private:
    static const std::string ModuleName;
    static const std::size_t MaxNumLanes;

    Path        root;
    ScalVal     enableReg;
    ScalVal_RO  dataValidReg;
    ScalVal_RO  statusValidCntReg;
    ScalVal_RO  sysRefPeriodMinReg;
    ScalVal_RO  sysRefPeriodMaxReg;
    ScalVal_RO  positionErrReg;
    ScalVal_RO  alignErrReg;
    Command     clearErrorsCmd;
    Command     resetGTsCmd;
    std::size_t numLanes;
};

#endif
