#include <hbvm.h>

int main( int argc, char * argv[] )
{
    hb_cmdargInit( argc, argv );
    hb_vmInit( HB_TRUE );
    return hb_vmQuit();
}
