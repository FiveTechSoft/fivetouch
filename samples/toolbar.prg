#include "FiveTouch.ch"
      
function Main()
      
   local oDlg := QDialog()
   local oBar := QToolBar( oDlg )
   local oBtn1, oBtn2

   oDlg:Resize( ScreenWidth(), ScreenHeight() )      
   WndSetColor( oDlg, nRGB( 200, 100, 0 ) )
   	
   oBar:SetIconSize( QSize( 80, 80 ) )   		
   oBar:AddWidget( oBtn1 := QToolButton( oBar ) )
   oBtn1:Connect( "clicked()", { || oDlg:End() } )
   oBtn1:SetIcon( QIcon( "./images/cancel.png" ) )

   oBar:AddWidget( oBtn2 := QToolButton( oBar ) )
   oBtn2:Connect( "clicked()", { || MsgInfo( "add" ) } )
   oBtn2:SetIcon( QIcon( "./images/plus.png" ) )

   oDlg:Exec()
         
return nil  
