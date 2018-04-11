#include "FiveTouch.ch"

function Main()

   local oDlg, oLayout, oLabel
   local oBtn1, oBtn2, oBtn3

   DEFINE DIALOG oDlg ;
      SIZE ScreenWidth(), ScreenHeight()

   oLayout = QVBoxLayout()
   oDlg:SetLayout( oLayout )

   oLabel = QLabel( oDlg )
   oLabel:Move( 0, 0 )
   oLabel:Resize( ScreenWidth(), ScreenHeight() )
   oLabel:SetPixmap( QPixmap( "./images/bus.png" ):Scaled( ScreenWidth(), ScreenHeight() ) )
   oLayout:AddWidget( oLabel )

   oBtn1 = QPushButton( oDlg )
   oBtn1:SetText( "Abrir viaje" )
   oLayout:AddWidget( oBtn1 )

   oBtn2 = QPushButton( oDlg )
   oBtn2:SetText( "Venta pasaje camino" )
   oLayout:AddWidget( oBtn2 )

   oBtn3 = QPushButton( oDlg )
   oBtn3:SetText( "Gastos varios" )
   oLayout:AddWidget( oBtn3 )

   oBtn4 = QPushButton( oDlg )
   oBtn4:SetText( "Cierre del viaje" )
   oLayout:AddWidget( oBtn4 )

   oBtn5 = QPushButton( oDlg )
   oBtn5:SetText( "Salir" )
   oBtn5:Connect( "clicked()", { || oDlg:End() } )
   oLayout:AddWidget( oBtn5 )

   ACTIVATE DIALOG oDlg

return nil
