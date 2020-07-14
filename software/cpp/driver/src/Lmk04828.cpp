#include "Lmk04828.h"

const std::string Lmk04828::ModuleName = "Lmk04828";

Lmk04828::Lmk04828(Path r)
:
    root            ( r->findByName( ModuleName.c_str() ) ),
    pwrDwnSysRefCmd ( ICommand::create( root->findByName("PwrDwnSysRef") ) )
{
    std::cout << ModuleName << " object created" << std::endl;
}

void Lmk04828::pwrDwnSysRef()
{
    // We will use the Command defined in YAML
    pwrDwnSysRefCmd->execute();
}
