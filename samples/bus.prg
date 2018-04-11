#include "FiveTouch.ch"

function Main()

   local oDlg, oLabel

   DEFINE DIALOG oDlg ;
      SIZE ScreenWidth(), ScreenHeight()

   oLabel = QLabel( oDlg )
   oLabel:Move( 0, 0 )
   oLabel:Resize( ScreenWidth(), ScreenHeight() )
   oLabel:SetPixmap( QPixmap( "./images/bus.png" ):Scaled( ScreenWidth(), ScreenHeight() ) )

   ACTIVATE DIALOG oDlg

return nil
