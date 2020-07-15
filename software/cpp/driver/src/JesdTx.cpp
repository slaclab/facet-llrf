#include "JesdTx.h"

const std::string JesdTx::ModuleName  = "JesdTx";
const std::size_t JesdTx::MaxNumLanes = 8;

JesdTx::JesdTx(Path r)
:
    root               ( r->findByName( ModuleName.c_str() ) ),
    enableReg          ( IScalVal::create( root->findByName("Enable") ) ),
    dataValidReg       ( IScalVal_RO::create( root->findByName("DataValid") ) ),
    statusValidCntReg  ( IScalVal_RO::create( root->findByName("StatusValidCnt") ) ),
    sysRefPeriodMinReg ( IScalVal_RO::create( root->findByName("SysRefPeriodmin") ) ),
    sysRefPeriodMaxReg ( IScalVal_RO::create( root->findByName("SysRefPeriodmax") ) ),
    clearErrorsCmd     ( ICommand::create( root->findByName("ClearTxStatus") ) ), 
    resetGTsCmd        ( ICommand::create( root->findByName("ResetTxGTs") ) ), 
    numLanes           ( enableReg->getSizeBits() )
{
    std::cout << ModuleName << " object created (number of lanes = " << numLanes << ")" << std::endl;
}

bool JesdTx::isLocked(bool verbose) const
{
    std::cout << "Checking if " << ModuleName << " is locked:" << std::endl;
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

    // Check that the status valid counters are zero
    statusValidCntReg->getVal(vec.data(), vec.size());
    printArray(statusValidCntReg->getName(), vec);
    success &= allZeros(vec);

    std::cout << std::endl;
    if ( success )
        std::cout << "Success! " << ModuleName << " is locked!" << std::endl;
    else
        std::cout << "Error! " << ModuleName << " is not locked!" << std::endl;

    std::cout << "----------------------------------" << std::endl;
    std::cout << std::endl;

    return success;
}

void JesdTx::setEnable(uint32_t enable) const
{
    enableReg->setVal(&enable);
}

uint32_t JesdTx::getEnable() const
{
    uint32_t u32;
    enableReg->getVal(&u32);
    return u32;
}

void JesdTx::clearErrors() const
{
    // We will use the Command defined in YAML
    clearErrorsCmd->execute();
}

void JesdTx::resetGTs() const
{
    // We will use the Command defined in YAML
    resetGTsCmd->execute();
}
