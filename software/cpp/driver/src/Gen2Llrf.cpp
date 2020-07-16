#include <unistd.h>
#include "Gen2Llrf.h"

const std::string IGen2Llrf::ModuleName = "Gen2Llrf";

Gen2Llrf IGen2Llrf::create(Path p)
{
    if(!p)
        throw std::runtime_error(ModuleName + " : The root Path is empty");

    return boost::make_shared<IGen2Llrf>(p);
}

IGen2Llrf::IGen2Llrf(Path p)
:
    root     ( p ),
    upConv   ( IGen2UpConverter::create(root) ),
    downConv ( IDownConverter::create(root) ),
    log      ( ModuleName.c_str() )
{
    log(LoggerLevel::Debug) << "Object created";
}

bool IGen2Llrf::init()
{
    log(LoggerLevel::Debug) << "Initilizing...";

    // Initilizaztion sequence
    bool success = downConv->init();
    success &= upConv->init();

    if ( success )
        log(LoggerLevel::Debug) << "Initilization succeed!";
    else
         log(LoggerLevel::Error) << "Initilization failed!";

    return success;
}
