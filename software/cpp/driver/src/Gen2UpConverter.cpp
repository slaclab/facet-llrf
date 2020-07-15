#include <unistd.h>
#include "Gen2UpConverter.h"

const std::string Gen2UpConverter::ModuleName = "AmcMrLlrfGen2UpConvert";

Gen2UpConverter::Gen2UpConverter(Path p)
:
    root           ( p->findByName( (CpswTopPaths::AppCore + ModuleName).c_str() ) ),
    jesdRoot       ( p->findByName( CpswTopPaths::AppTopJesdBay1.c_str() ) ),
    jesdRx         ( jesdRoot ),
    jesdTx         ( jesdRoot ),
    lmk            ( root ),
    dac            ( root ),
    initAmcCardCmd ( ICommand::create(root->findByName("InitAmcCard") ) )
{
    std::cout << ModuleName << " object created" << std::endl;
}

bool Gen2UpConverter::init()
{
    std::cout << "Initilizing " << ModuleName << "..." << std::endl;

    // Initilizaztion sequence
    bool success;
    std::size_t maxRetries { 10 };
    for (std::size_t i {1}; i <= maxRetries; ++i)
    {
        std::cout << "Initilization try # " << i << "..." << std::endl;
        std::cout << "===========================" << std::endl;

        // - Read current JesdRx/Tx enabled lanes
        uint32_t rxEn, txEn;
        rxEn = jesdRx.getEnable();
        txEn = jesdTx.getEnable();
        // - Disable all JesdRx/Tx lanes
        jesdRx.setEnable(0);
        jesdTx.setEnable(0);
        // - Init DAC
        dac.init();
        // - Reset JesdRx/Tx GTs
        jesdRx.resetGTs();
        jesdTx.resetGTs();

        sleep(1);

        // - Clear JesdRx errors
        jesdRx.clearErrors();
        // - Restore JesdRx/Tx enabled lanes
        jesdRx.setEnable(rxEn);
        jesdTx.setEnable(txEn);

        sleep(2);

        // - Init Dac 
        dac.init();
        dac.clearAlarms();
        dac.ncoSync();
        dac.clearAlarms();
        // - Clear JesdTx errors
        jesdTx.clearErrors();

        sleep(2);

        // JESD Link Health Checking
        // - Check DAC errors
        success = dac.isLocked();
        // - Check JesdTx errors
        success &= jesdTx.isLocked();
        // - Check JesdRx errors
        success &= jesdRx.isLocked();

       std::cout << std::endl;

       if ( success )
       {
           std::cout << "Initilization succeed!" << std::endl;
           break;
       }
       else
       {
           if ( i == maxRetries )
           {
               std::cerr << "Initilization failed after " << maxRetries << " retries. Aborting!" << std::endl;
               break;
           }
           else
           {
               std::cerr << "Initilization # " << i << " failed. Retying..." << std::endl;
               std::cout << std::endl;
           }
       }
    }

    std::cout << "===========================" << std::endl;
    std::cout << std::endl;

    return success;
}

bool Gen2UpConverter::isInited()
{
    std::cout << "Checking if " << ModuleName <<" is initilize:" << std::endl;
    std::cout << "---------------------------------------------------" << std::endl;

    uint32_t u32[8];
    bool success { true };

    // Check if DAC is locked
    success &= dac.isLocked();

    // Check is JesdRx is locked
    success &= jesdRx.isLocked();

    // Check if JesdTx is locked
    success &= jesdTx.isLocked();

    std::cout << std::endl;
    if ( success )
        std::cout << "Success! " << ModuleName << " is locked." << std::endl;
    else
        std::cout << "Error! " << ModuleName << " is not locked." << std::endl;

    std::cout << "---------------------------------------------------" << std::endl;
    std::cout << std::endl;

    return success;
}

