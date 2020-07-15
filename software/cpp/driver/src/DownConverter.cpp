#include <unistd.h>
#include "DownConverter.h"

const std::string DownConverter::ModuleName = "AmcMrLlrfDownConvert";

DownConverter::DownConverter(Path p)
:
    root           ( p->findByName( (CpswTopPaths::AppCore + ModuleName).c_str() ) ),
    jesdRoot       ( p->findByName( CpswTopPaths::AppTopJesdBay0.c_str() ) ),
    jesdRx         ( jesdRoot ),
    lmk            ( root ),
    initAmcCardCmd ( ICommand::create(root->findByName("InitAmcCard") ) )
{
    std::cout << ModuleName << " object created" << std::endl;
}

bool DownConverter::init()
{
    std::cout << "Initilizating " << ModuleName << "..." << std::endl;

    // Initilizaztion sequence
    bool success;
    std::size_t maxRetries { 10 };
    for (std::size_t i {1}; i <= maxRetries; ++i)
    {
        std::cout << "Initilization try # " << i << "..." << std::endl;
        std::cout << "===========================" << std::endl;

        // - Power down Lmk sys ref
        lmk.pwrDwnSysRef();
        // - Reset JesdRx GTs
        jesdRx.resetGTs();
        // - Init AMC card
        initAmcCardCmd->execute();
        // - Clear JesdRx errors
        jesdRx.clearErrors();
        
        sleep(1);

        // JESD Link Health Checking
        // - Check JesdRx errors
        success = jesdRx.isLocked();

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

bool DownConverter::isInited()
{
    std::cout << "Checking if " << ModuleName << " is initilize:" << std::endl;
    std::cout << "---------------------------------------------------" << std::endl;

    // Check is JesdRx is locked
    bool success { jesdRx.isLocked() };

    std::cout << std::endl;
    if ( success )
        std::cout << "Success! " << ModuleName << " is locked." << std::endl;
    else
        std::cout << "Error! " << ModuleName << " is not locked." << std::endl;

    std::cout << "---------------------------------------------------" << std::endl;
    std::cout << std::endl;

    return success;
}

