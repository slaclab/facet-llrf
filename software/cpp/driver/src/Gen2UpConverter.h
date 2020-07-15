#ifndef _GEN2UPCONVERTER_H_
#define _GEN2UPCONVERTER_H_

#include <iostream>
#include <yaml-cpp/yaml.h>
#include <cpsw_api_user.h>

#include "CpswTopPaths.h"
#include "JesdRx.h"
#include "JesdTx.h"
#include "Lmk04828.h"
#include "Dac38J84.h"
#include "Logger.h"

class Gen2UpConverter
{
public: 
    Gen2UpConverter(Path r);

    bool init();

    bool isInited();

private:
    static const std::string ModuleName;

    Path       root;
    Path       jesdRoot;

    // Devices
    JesdRx     jesdRx;
    JesdTx     jesdTx;
    Lmk04828   lmk;
    Dac38J84   dac;

    // Local commands
    Command    initAmcCardCmd;

    // Logger
    Logger     log;
};

#endif
