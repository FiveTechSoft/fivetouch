#include "FiveTouch.ch"

//----------------------------------------------------------------------------//

function Main()

   local oIde

   ErrorBlock( { | o | DoBreak( o ) } )

   Link()
   ExtendClasses()
   CopyFiles()

   oIde = TIde():New()
   oIde:PhoneMode()
   
return nil

//----------------------------------------------------------------------------//
