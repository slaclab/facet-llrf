#ifndef _DOWNCONVERTER_H_
#define _DOWNCONVERTER_H_

#include <iostream>
#include <yaml-cpp/yaml.h>
#include <cpsw_api_user.h>

#include "JesdRx.h"
#include "Lmk04828.h"

class DownConverter
{
public: 
    DownConverter(Path r);

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
    Lmk04828   lmk;

    // Local commands
    Command    initAmcCardCmd;
};

#endif
