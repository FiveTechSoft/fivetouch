#include "FiveTouch.ch"

//----------------------------------------------------------------------------//

function Main()

   local oIde

   ErrorBlock( { | o | DoBreak( o ) } )

   Link()
   ExtendClasses()
   CopyFiles()

   QApplication():SetStyleSheet( DarkOrangeStyle() )

   oIde = TIde():New()
   oIde:PhoneMode()
   
return nil

//----------------------------------------------------------------------------//
