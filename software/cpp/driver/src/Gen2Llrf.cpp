#include <unistd.h>
#include "Gen2Llrf.h"

Gen2Llrf::Gen2Llrf(Path r)
:
    root     ( r ),
    upConv   ( root ),
    downConv ( root )
{
    std::cout << "Gen2 LLRF object created" << std::endl;
}

bool Gen2Llrf::init()
{
    std::cout << "Executing Gen2 LLRF init sequence..." << std::endl;

    // Initilizaztion sequence
    bool success = downConv.init();
    success &= upConv.init();


    if ( success )
        std::cout << "Initilization succeed!" << std::endl;
    else
        std::cout << "Initilization failed!" << std::endl;
    return success;
}
