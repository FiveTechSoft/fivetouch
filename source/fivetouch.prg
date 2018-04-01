#include "FiveTouch.ch"

#define __HBEXTREQ__
#include "harbour.hbx"
#include "c:\harbour\contrib\hbct\hbct.hbx"

//----------------------------------------------------------------------------//

function Main()

   local oOldError := ErrorBlock( { | o | DoBreak( o ) } )
   local oIde := TIde():New()

   Build_FiveTouch_CH()
   
   SysRefresh()
   
   oIde:PhoneMode()
   
return nil

//----------------------------------------------------------------------------//
