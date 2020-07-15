#ifndef _GEN2LLRF_H_
#define _GEN2LLRF_H_

#include <iostream>
#include <yaml-cpp/yaml.h>
#include <cpsw_api_user.h>

#include "Gen2UpConverter.h"
#include "DownConverter.h"

class Gen2Llrf
{
public: 
    Gen2Llrf(Path r);

    bool init();

    bool isInited();

private:
    Path       root;

    // Devices
    Gen2UpConverter upConv;
    DownConverter   downConv;
};

#endif
