#include "FiveTouch.ch"

//----------------------------------------------------------------------------// 

function MsgInfo( cMsg, cTitle )

  local oMsg := QMessageBox():New()

  cTitle = If( cTitle == NIL, "Information", cTitle )
  
  oMsg:SetText( cValToChar( cMsg ) )
  oMsg:SetWindowTitle( cTitle )
  oMsg:SetStandardButtons( 0x400 )
  oMsg:SetIcon( 1 )

  oMsg:Exec()

return nil 

//----------------------------------------------------------------------------// 

function MsgYesNo( cMsg, cTitle )

  local oMsg := QMessageBox():New()

  cTitle = If( cTitle == NIL, "Question", cTitle )
  
  oMsg:SetText( cValToChar( cMsg ) )
  oMsg:SetWindowTitle( cTitle )
  oMsg:SetStandardButtons( hb_BitOr( 0x4000, 0x10000 ) )
  oMsg:SetIcon( 4 )

return oMsg:Exec() == 0x4000 

//----------------------------------------------------------------------------//

function MsgGet( cMsg, uValue )

   local oDlg := QDialog()
   local oLayout := QVBoxLayout()
   local oGet := QLineEdit( oDlg )
   local oBtnBar := QWidget( oDlg )
   local oBtnBarLayout := QHBoxLayout()
   local oBtnOk := QPushButton( oBtnBar )
   local oBtnCancel := QPushButton( oBtnBar )

   uValue = If( uValue == nil, Space( 200 ), uValue )

   oBtnOk:SetText( "Ok" )
   oBtnOk:Connect( "clicked()",;
   	{ || uValue := AllTrim( oGet:Text() ), oDlg:Done( 1 ) } )	
   oBtnCancel:SetText( "Cancel" )
   oBtnCancel:Connect( "clicked()", { || uValue := nil, oDlg:Done( 2 ) } ) 
   oBtnBar:SetLayout( oBtnBarLayout ) 
   oBtnBarLayout:AddWidget( oBtnOk )
   oBtnBarLayout:AddWidget( oBtnCancel )

   oDlg:SetWindowTitle( cMsg )
   oDlg:SetLayout( oLayout )
   
   oGet:SetText( cValToChar( uValue ) )	
   oLayout:AddWidget( oGet )
   oLayout:AddWidget( oBtnBar ) 

   oDlg:Exec()

return uValue

//----------------------------------------------------------------------------//

function QSelFile( oWndParent, cTitle, cPath, cFilter )

   DEFAULT oWndParent := WndMain()
   DEFAULT cTitle := "Open Files Source/Header"
   DEFAULT cPath   := ".\"
   DEFAULT cFilter := "Source/Header Files (*.prg *.ch *.h)"

return QFileDialog( oWndParent ):GetOpenFileName( oWndParent, cTitle, cPath, cFilter )

//----------------------------------------------------------------------------//
