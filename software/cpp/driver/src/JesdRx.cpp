#include "JesdRx.h"

const std::string JesdRx::ModuleName  = "JesdRx";
const std::size_t JesdRx::MaxNumLanes = 8;

JesdRx::JesdRx(Path r)
:
    root               ( r->findByName( ModuleName.c_str() ) ),
    enableReg          ( IScalVal::create( root->findByName("Enable") ) ),
    dataValidReg       ( IScalVal_RO::create( root->findByName("DataValid") ) ),
    statusValidCntReg  ( IScalVal_RO::create( root->findByName("StatusValidCnt") ) ),
    sysRefPeriodMinReg ( IScalVal_RO::create( root->findByName("SysRefPeriodmin") ) ),
    sysRefPeriodMaxReg ( IScalVal_RO::create( root->findByName("SysRefPeriodmax") ) ),
    positionErrReg     ( IScalVal_RO::create( root->findByName("PositionErr") ) ),
    alignErrReg        ( IScalVal_RO::create( root->findByName("AlignErr") ) ),
    clearErrorsCmd     ( ICommand::create( root->findByName("ClearRxErrors") ) ), 
    resetGTsCmd        ( ICommand::create( root->findByName("ResetRxGTs") ) ), 
    numLanes           ( enableReg->getSizeBits() ),
    log                ( ModuleName.c_str() )
{
    log(LoggerLevel::Debug) << "Object created. Number of lanes = " + to_string(numLanes);
}

bool JesdRx::isLocked()
{
    log(LoggerLevel::Debug) << "Checking lock status:";
    log(LoggerLevel::Debug) << "----------------------------------";

    bool success { true };

    // Verify that SysRefPeriodMin == SysRefPeriodMax
    uint32_t sysRefPeriodMin, sysRefPeriodMax;
    sysRefPeriodMinReg->getVal(&sysRefPeriodMin);
    sysRefPeriodMaxReg->getVal(&sysRefPeriodMax);
    log(LoggerLevel::Debug) << "SysRefPeriodMin = " + to_string(sysRefPeriodMin);
    log(LoggerLevel::Debug) << "SysRefPeriodMax = " + to_string(sysRefPeriodMax);
    success = (sysRefPeriodMin == sysRefPeriodMax);

    // Check that all the enabled lanes have DataValid
    // - Get the enable mask
    uint32_t enable;
    enableReg->getVal(&enable);
    log(LoggerLevel::Debug) << "Enable = " + to_string(enable);
    // - Get the DataValid values
    std::vector<uint32_t> vec(numLanes);
    dataValidReg->getVal(vec.data(), vec.size());
    log(LoggerLevel::Debug) << vec2str(dataValidReg->getName(), vec);
    // - Finally, compare the DataValid (converted to word) and enable mask
    success &= ( vec2word(vec) == enable );

    // Check that the PositionErr are all zeros
    positionErrReg->getVal(vec.data(), vec.size());
    log(LoggerLevel::Debug) << vec2str(positionErrReg->getName(), vec);
    success &= allZeros(vec);

    // Check that the AlignErr are all zeros
    alignErrReg->getVal(vec.data(), vec.size());
    log(LoggerLevel::Debug) << vec2str(alignErrReg->getName(), vec);
    success &= allZeros(vec);

    // Check that the status valid counters lower or equal than 4
    statusValidCntReg->getVal(vec.data(), vec.size());
    log(LoggerLevel::Debug) << vec2str(statusValidCntReg->getName(), vec);
    uint32_t max = *(std::max_element(vec.begin(), vec.end()));
    success &= ( max <= 4 );

    if ( success )
        log(LoggerLevel::Debug) << "It is locked!";
    else
        log(LoggerLevel::Error) <<  "It is not locked!";

    log(LoggerLevel::Debug) << "----------------------------------";

    return success;
}

void JesdRx::setEnable(uint32_t enable) const
{
    enableReg->setVal(&enable);
}

uint32_t JesdRx::getEnable() const
{
    uint32_t u32;
    enableReg->getVal(&u32);
    return u32;
}

void JesdRx::clearErrors() const
{
    // We will use the Command defined in YAML
    clearErrorsCmd->execute();
}

void JesdRx::resetGTs() const
{
    // We will use the Command defined in YAML
    resetGTsCmd->execute();
}
