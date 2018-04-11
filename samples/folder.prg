#include "FiveTouch.ch"

function Main()

   local oDlg := QDialog()
   local oLayout := QVBoxLayout()
   local oFolder := QTabWidget( oDlg )
 
   oDlg:SetLayout( oLayout )
   oLayout:AddWidget( oFolder )
   oDlg:SetWindowTitle( "A folder" )
   oDlg:Resize( 400, 400 )  

   oFolder:AddTab( QWidget(), "One" )
   oFolder:AddTab( QWidget(), "Two" )
   oFolder:AddTab( QWidget(), "Three" )

   oDlg:Center()
   oDlg:Exec()

return nil
