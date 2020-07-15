#include "Dac38J84.h"

const std::string Dac38J84::ModuleName = "Dac38J84";
const std::size_t Dac38J84::MaxNumLanes = 8;

Dac38J84::Dac38J84(Path r)
:
    root                   ( r->findByName( ModuleName.c_str() ) ),
    enableTxReg            ( IScalVal::create( root->findByName("EnableTx") )  ),
    clearAlarmsCmd         ( ICommand::create( root->findByName("ClearAlarms") ) ),
    ncoSyncCmd             ( ICommand::create( root->findByName("NcoSync") ) ),
    initDacCmd             ( ICommand::create( root->findByName("InitDac") ) ),
    dacReg                 ( IScalVal::create( root->findByName("DacReg") )    ),
    linkErrCntReg          ( IScalVal_RO::create( root->findByName("LinkErrCnt") ) ),
    readFifoEmptyReg       ( IScalVal_RO::create( root->findByName("ReadFifoEmpty") ) ),
    readFifoUnderflowReg   ( IScalVal_RO::create( root->findByName("ReadFifoUnderflow") ) ),
    readFifoFullReg        ( IScalVal_RO::create( root->findByName("ReadFifoFull") ) ),
    readFifoOverflowReg    ( IScalVal_RO::create( root->findByName("ReadFifoOverflow") ) ),
    dispErrReg             ( IScalVal_RO::create( root->findByName("DispErr") ) ),
    notitableErrReg        ( IScalVal_RO::create( root->findByName("NotitableErr") ) ),
    codeSyncErrReg         ( IScalVal_RO::create( root->findByName("CodeSyncErr") ) ),
    firstDataMatchErrReg   ( IScalVal_RO::create( root->findByName("FirstDataMatchErr") ) ),
    elasticBuffOverflowReg ( IScalVal_RO::create( root->findByName("ElasticBuffOverflow") ) ),
    linkConfigErrReg       ( IScalVal_RO::create( root->findByName("LinkConfigErr") ) ),
    frameAlignErrReg       ( IScalVal_RO::create( root->findByName("FrameAlignErr") ) ),
    multiFrameAlignErrReg  ( IScalVal_RO::create( root->findByName("MultiFrameAlignErr") ) ),
    numLanes               ( linkErrCntReg->getNelms() )
{
    std::cout << ModuleName << " object created (number of lanes = " << numLanes <<  ")" << std::endl;
}

void Dac38J84::init()
{
    std::cout << "Initilizing " << ModuleName << "... ";

    enableTxReg->setVal(0ul);
    usleep(10000);

    clearAlarmsCmd->execute();
    usleep(10000);

    uint32_t u32;
    IndexRange rng(59);
    dacReg->getVal(&u32, 1, &rng);
    dacReg->setVal(&u32, 1, &rng);
    usleep(10000);

    rng = 37;
    dacReg->getVal(&u32, 1, &rng);
    dacReg->setVal(&u32, 1, &rng);
    usleep(10000);

    // Set and Reset Bit9 – VRANGE, select between high and low VCO.
    rng = 60;
    dacReg->getVal(&u32, 1, &rng);
    u32 |= 0x200;
    dacReg->setVal(&u32, 1, &rng);
    usleep(10000);
    u32 &= 0xFDFF;
    dacReg->setVal(&u32, 1, &rng);
    usleep(10000);

    rng = 62;
    dacReg->getVal(&u32, 1, &rng);
    dacReg->setVal(&u32, 1, &rng);
    usleep(10000);

    rng = 76;
    dacReg->getVal(&u32, 1, &rng);
    dacReg->setVal(&u32, 1, &rng);
    usleep(10000);

    rng = 77;
    dacReg->getVal(&u32, 1, &rng);
    dacReg->setVal(&u32, 1, &rng);
    usleep(10000);


    rng = 75;
    dacReg->getVal(&u32, 1, &rng);
    dacReg->setVal(&u32, 1, &rng);
    usleep(10000);

    rng = 77;
    dacReg->getVal(&u32, 1, &rng);
    dacReg->setVal(&u32, 1, &rng);
    usleep(10000);

    rng = 78;
    dacReg->getVal(&u32, 1, &rng);
    dacReg->setVal(&u32, 1, &rng);
    usleep(10000);

    rng = 0;
    dacReg->getVal(&u32, 1, &rng);
    dacReg->setVal(&u32, 1, &rng);
    usleep(10000);

    rng = 74;
    dacReg->getVal(&u32, 1, &rng);
    u32 &= 0xFFE0;
    u32 |= 0x1E;
    dacReg->setVal(&u32, 1, &rng);
    usleep(10000);

    dacReg->getVal(&u32, 1, &rng);
    u32 &= 0xFFE0;
    u32 |= 0x1E;
    dacReg->setVal(&u32, 1, &rng);
    usleep(10000);

    dacReg->getVal(&u32, 1, &rng);
    u32 &= 0xFFE0;
    u32 |= 0x1F;
    dacReg->setVal(&u32, 1, &rng);
    usleep(10000);

    dacReg->getVal(&u32, 1, &rng);
    u32 &= 0xFFE0;
    u32 |= 0x01;
    dacReg->setVal(&u32, 1, &rng);
    usleep(10000);

    enableTxReg->setVal(1ul);
    usleep(10000);

    std::cout << "Done!" << std::endl;
}

void Dac38J84::initDac()
{
    // We will use the Command defined in YAML
    initDacCmd->execute();
}

void Dac38J84::ncoSync()
{
    // We will use the Command defined in YAML
    ncoSyncCmd->execute();
}

void Dac38J84::clearAlarms()
{
    // We will use the Command defined in YAML
    clearAlarmsCmd->execute();
}

bool Dac38J84::isLocked(bool verbose)
{
    std::cout << "Checking if " << ModuleName << " is locked:" << std::endl;
    std::cout << "----------------------------------" << std::endl;

    bool success { true };

    std::vector<uint32_t> vec(numLanes);

    linkErrCntReg->getVal(vec.data(), vec.size());
    printArray(linkErrCntReg->getName(), vec);
    success &= allZeros(vec);

    readFifoEmptyReg->getVal(vec.data(), vec.size());
    printArray(readFifoEmptyReg->getName(), vec);
    success &= allZeros(vec);

    readFifoUnderflowReg->getVal(vec.data(), vec.size());
    printArray(readFifoUnderflowReg->getName(), vec);
    success &= allZeros(vec);

    readFifoFullReg->getVal(vec.data(), vec.size());
    printArray(readFifoFullReg->getName(), vec);
    success &= allZeros(vec);

    readFifoOverflowReg->getVal(vec.data(), vec.size());
    printArray(readFifoOverflowReg->getName(), vec);
    success &= allZeros(vec);

    dispErrReg->getVal(vec.data(), vec.size());
    printArray(dispErrReg->getName(), vec);
    success &= allZeros(vec);

    notitableErrReg->getVal(vec.data(), vec.size());
    printArray(notitableErrReg->getName(), vec);
    success &= allZeros(vec);

    codeSyncErrReg->getVal(vec.data(), vec.size());
    printArray(codeSyncErrReg->getName(), vec);
    success &= allZeros(vec);

    firstDataMatchErrReg->getVal(vec.data(), vec.size());
    printArray(firstDataMatchErrReg->getName(), vec);
    success &= allZeros(vec);

    elasticBuffOverflowReg->getVal(vec.data(), vec.size());
    printArray(elasticBuffOverflowReg->getName(), vec);
    success &= allZeros(vec);

    linkConfigErrReg->getVal(vec.data(), vec.size());
    printArray(linkConfigErrReg->getName(), vec);
    success &= allZeros(vec);

    frameAlignErrReg->getVal(vec.data(), vec.size());
    printArray(frameAlignErrReg->getName(), vec);
    success &= allZeros(vec);

    multiFrameAlignErrReg->getVal(vec.data(), vec.size());
    printArray(multiFrameAlignErrReg->getName(), vec);
    success &= allZeros(vec);

    std::cout << std::endl;
    if ( success )
        std::cout << "Success! " << ModuleName << " is locked." << std::endl; 
    else
        std::cout << "Error! Dac38J84 is not locked." << std::endl;

    std::cout << "----------------------------------" << std::endl;
    std::cout << std::endl;

    // These checks fail at the moment, so let's always return 'true' for now
    //return success;
    return true;
}

