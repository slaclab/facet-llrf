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
    numLanes           ( enableReg->getSizeBits() )
{
    std::cout << "JesdRx object created (number of lanes = " << numLanes << ")" << std::endl;
}

bool JesdRx::isLocked(bool verbose) const
{
    std::cout << "Checking is JesdRx is locked:" << std::endl;
    std::cout << "----------------------------------" << std::endl;

    bool success { true };

    // Verify that SysRefPeriodMin == SysRefPeriodMax
    uint32_t sysRefPeriodMin, sysRefPeriodMax;
    sysRefPeriodMinReg->getVal(&sysRefPeriodMin);
    sysRefPeriodMaxReg->getVal(&sysRefPeriodMax);
    std::cout << "SysRefPeriodMin = " << sysRefPeriodMin << std::endl;
    std::cout << "SysRefPeriodMax = " << sysRefPeriodMax << std::endl;
    success = (sysRefPeriodMin == sysRefPeriodMax);

    // Check that all the enabled lanes have DataValid
    // - Get the enable mask
    uint32_t enable;
    enableReg->getVal(&enable);
    std::cout << "Enable = " << enable << std::endl;
    // - Get the DataValid values
    std::vector<uint32_t> vec(numLanes);
    dataValidReg->getVal(vec.data(), vec.size());
    printArray(dataValidReg->getName(), vec);
    // - Finally, compare the DataValid (converted to word) and enable mask
    success &= ( vec2word(vec) == enable );

    // Check that the PositionErr are all zeros
    positionErrReg->getVal(vec.data(), vec.size());
    printArray(positionErrReg->getName(), vec);
    success &= allZeros(vec);

    // Check that the AlignErr are all zeros
    alignErrReg->getVal(vec.data(), vec.size());
    printArray(alignErrReg->getName(), vec);
    success &= allZeros(vec);

    // Check that the status valid counters lower or equal than 4
    statusValidCntReg->getVal(vec.data(), vec.size());
    printArray(statusValidCntReg->getName(), vec);
    uint32_t max = *(std::max_element(vec.begin(), vec.end()));
    success &= ( max <= 4 );

    std::cout << std::endl;
    if ( success )
        std::cout << "Success! JedRx is locked!" << std::endl;
    else
        std::cout << "Error! JedRx is not locked!" << std::endl;

    std::cout << "----------------------------------" << std::endl;
    std::cout << std::endl;

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
