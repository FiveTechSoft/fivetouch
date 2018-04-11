#include "FiveTouch.ch"

function Main()

   local oDlg, oLayout, oLabel, oBtn1

   DEFINE DIALOG oDlg ;
      SIZE ScreenWidth(), ScreenHeight()

   oLayout = QVBoxLayout()
   oDlg:SetLayout( oLayout )

   oLabel = QLabel( oDlg )
   oLabel:Move( 0, 0 )
   oLabel:Resize( ScreenWidth(), ScreenHeight() )
   oLabel:SetPixmap( QPixmap( "./images/bus.png" ):Scaled( ScreenWidth(), ScreenHeight() ) )
   oLayout:AddWidget( oLabel )

   oBtn1 = QButton( oDlg )
   oBtn1:SetText( "Abrir viaje" )
   oLayout:AddWidget( oBtn1 )

   ACTIVATE DIALOG oDlg

return nil
