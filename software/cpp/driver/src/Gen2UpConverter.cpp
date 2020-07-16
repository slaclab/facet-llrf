#include <unistd.h>
#include "Gen2UpConverter.h"

const std::string Gen2UpConverter::ModuleName = "AmcMrLlrfGen2UpConvert";

Gen2UpConverter::Gen2UpConverter(Path p)
:
    root           ( p->findByName( (CpswTopPaths::AppCore + ModuleName).c_str() ) ),
    jesdRoot       ( p->findByName( CpswTopPaths::AppTopJesdBay1.c_str() ) ),
    jesdRx         ( IJesdRx::create(jesdRoot) ),
    jesdTx         ( jesdRoot ),
    lmk            ( root ),
    dac            ( root ),
    initAmcCardCmd ( ICommand::create(root->findByName("InitAmcCard") ) ),
    log            ( ModuleName.c_str() )
{
     log(LoggerLevel::Debug) << "Object created";
}

bool Gen2UpConverter::init()
{
    log(LoggerLevel::Debug) << "Initilizing...";

    // Initilizaztion sequence
    bool success;
    std::size_t maxRetries { 10 };
    for (std::size_t i {1}; i <= maxRetries; ++i)
    {
        log(LoggerLevel::Debug) << "Initilization try # " + to_string(i) + ":";
        log(LoggerLevel::Debug) << "===========================";

        // - Read current JesdRx/Tx enabled lanes
        uint32_t rxEn, txEn;
        rxEn = jesdRx->getEnable();
        txEn = jesdTx.getEnable();
        // - Disable all JesdRx/Tx lanes
        jesdRx->setEnable(0);
        jesdTx.setEnable(0);
        // - Init DAC
        dac.init();
        // - Reset JesdRx/Tx GTs
        jesdRx->resetGTs();
        jesdTx.resetGTs();

        sleep(1);

        // - Clear JesdRx errors
        jesdRx->clearErrors();
        // - Restore JesdRx/Tx enabled lanes
        jesdRx->setEnable(rxEn);
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
        success &= jesdRx->isLocked();

       if ( success )
       {
           log(LoggerLevel::Debug) << "Initilization succeed!";
           break;
       }
       else
       {
           if ( i == maxRetries )
           {
               log(LoggerLevel::Error) << "Initilization failed after " + to_string(maxRetries) + " retries. Aborting!";
               break;
           }
           else
           {
               log(LoggerLevel::Warning) << "Initilization # " + to_string(i) + " failed. Retying...";
           }
       }
    }

    log(LoggerLevel::Debug) << "===========================";

    return success;
}

bool Gen2UpConverter::isInited()
{
    log(LoggerLevel::Debug) << "Checking lock status:";
    log(LoggerLevel::Debug) << "----------------------------------";

    bool success { true };

    // Check if DAC is locked
    success &= dac.isLocked();

    // Check is JesdRx is locked
    success &= jesdRx->isLocked();

    // Check if JesdTx is locked
    success &= jesdTx.isLocked();

    if ( success )
        log(LoggerLevel::Debug) << "It is locked!";
    else
        log(LoggerLevel::Error) << "It is not locked!";

    log(LoggerLevel::Debug) << "----------------------------------";

    return success;
}

