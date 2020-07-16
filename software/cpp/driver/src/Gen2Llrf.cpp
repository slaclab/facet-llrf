#include <unistd.h>
#include "Gen2Llrf.h"

const std::string Gen2Llrf::ModuleName = "Gen2Llrf";

Gen2Llrf::Gen2Llrf(Path r)
:
    root     ( r ),
    upConv   ( IGen2UpConverter::create(root) ),
    downConv ( root ),
    log      ( ModuleName.c_str() )
{
    log(LoggerLevel::Debug) << "Object created";
}

bool Gen2Llrf::init()
{
    log(LoggerLevel::Debug) << "Initilizing...";

    // Initilizaztion sequence
    bool success = downConv.init();
    success &= upConv->init();

    if ( success )
        log(LoggerLevel::Debug) << "Initilization succeed!";
    else
         log(LoggerLevel::Error) << "Initilization failed!";

    return success;
}
