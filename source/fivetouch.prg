#include "FiveTouch.ch"

#define __HBEXTREQ__
#include "harbour.hbx"
#include "c:\harbour\contrib\hbct\hbct.hbx"

//----------------------------------------------------------------------------//

function Main()

   local oIde

   ErrorBlock( { | o | DoBreak( o ) } )

   ExtendClasses()
   Build_FiveTouch_CH()

   oIde = TIde():New()
   oIde:PhoneMode()
   
return nil

//----------------------------------------------------------------------------//
