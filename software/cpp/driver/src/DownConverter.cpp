#include <unistd.h>
#include "DownConverter.h"

const std::string DownConverter::ModuleName = "AmcMrLlrfDownConvert";

DownConverter::DownConverter(Path p)
:
    root           ( p->findByName( (CpswTopPaths::AppCore + ModuleName).c_str() ) ),
    jesdRoot       ( p->findByName( CpswTopPaths::AppTopJesdBay0.c_str() ) ),
    jesdRx         ( IJesdRx::create(jesdRoot) ),
    lmk            ( root ),
    initAmcCardCmd ( ICommand::create(root->findByName("InitAmcCard") ) ),
    log            ( ModuleName.c_str() )
{
    log(LoggerLevel::Debug) << "Object created";
}

bool DownConverter::init()
{
    log(LoggerLevel::Debug) << "Initilizating...";

    // Initilizaztion sequence
    bool success;
    std::size_t maxRetries { 10 };
    for (std::size_t i {1}; i <= maxRetries; ++i)
    {
        log(LoggerLevel::Debug) << "Initilization try # " + to_string(i) + ":";
        log(LoggerLevel::Debug) << "===========================";

        // - Power down Lmk sys ref
        lmk.pwrDwnSysRef();
        // - Reset JesdRx GTs
        jesdRx->resetGTs();
        // - Init AMC card
        initAmcCardCmd->execute();
        // - Clear JesdRx errors
        jesdRx->clearErrors();
        
        sleep(1);

        // JESD Link Health Checking
        // - Check JesdRx errors
        success = jesdRx->isLocked();

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

bool DownConverter::isInited()
{
    log(LoggerLevel::Debug) << "Checking lock status:";
    log(LoggerLevel::Debug) << "----------------------------------";

    // Check is JesdRx is locked
    bool success { jesdRx->isLocked() };

    if ( success )
        log(LoggerLevel::Debug) << "It is locked!";
    else
        log(LoggerLevel::Error) << "It is not locked!";

    log(LoggerLevel::Debug) << "----------------------------------";

    return success;
}

