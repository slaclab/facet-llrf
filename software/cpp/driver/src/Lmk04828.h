#ifndef _LMK04828_H_
#define _LMK04828_H_

#include <string>
#include <unistd.h>
#include <cpsw_api_user.h>

#include "helpers.h"
#include "Logger.h"

class Lmk04828
{
public:
    Lmk04828(Path r);

    void pwrDwnSysRef();

private:
    static const std::string ModuleName;

    Path        root;
    Command     pwrDwnSysRefCmd;
    Logger      log;
};

#endif
