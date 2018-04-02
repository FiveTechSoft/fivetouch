#include "FiveTouch.ch"

#define __HBEXTREQ__
#include "harbour.hbx"
#include "c:\harbour\contrib\hbct\hbct.hbx"

//----------------------------------------------------------------------------//

function Main()

   local oIde

   ErrorBlock( { | o | DoBreak( o ) } )

   ExtendClasses()

   QFile( "assets:/FiveTouch.ch" ):copy( "FiveTouch.ch" )
   QFile( "assets:/hbclass.ch" ):copy( "hbclass.ch" )
   QFile( "assets:/hboo.ch" ):copy( "hboo.ch" )

   oIde = TIde():New()
   oIde:PhoneMode()
   
return nil

//----------------------------------------------------------------------------//
