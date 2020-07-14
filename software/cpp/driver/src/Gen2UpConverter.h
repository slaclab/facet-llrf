#ifndef _GEN2UPCONVERTER_H_
#define _GEN2UPCONVERTER_H_

#include <iostream>
#include <yaml-cpp/yaml.h>
#include <cpsw_api_user.h>

#include "JesdRx.h"
#include "JesdTx.h"
#include "Lmk04828.h"
#include "Dac38J84.h"

class Gen2UpConverter
{
public: 
    Gen2UpConverter(Path r);

    bool init();

    bool isInited();

private:
    static const std::string JesdTopModuleName;
    static const std::string AmcTopModuleName;
    Path       root;
    Path       jesdRoot;
    Path       amcRoot;

    // Devices
    JesdRx     jesdRx;
    JesdTx     jesdTx;
    Lmk04828   lmk;
    Dac38J84   dac;

    // Local commands
    Command    initAmcCardCmd;
};

#endif
