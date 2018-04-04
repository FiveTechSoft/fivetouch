//----------------------------------------------------------------------------// 

function cFileNoExt( cPathMask ) // returns the filename without ext

   local cName := AllTrim( cFileNoPath( cPathMask ) )
   local n     := RAt( ".", cName )

return AllTrim( If( n > 0, Left( cName, n - 1 ), cName ) )

//----------------------------------------------------------------------------//

function cFileNoPath( cPathMask )  // returns just the filename no path

    local n := RAt( "\", cPathMask )

return If( n > 0 .and. n < Len( cPathMask ),;
           Right( cPathMask, Len( cPathMask ) - n ),;
           If( ( n := At( ":", cPathMask ) ) > 0 .or. ;
           	   ( n := At( "/", cPathMask ) ) > 0,;
           Right( cPathMask, Len( cPathMask ) - n ),;
           cPathMask ) )
           
//----------------------------------------------------------------------------//

function lIsDir( cDirName )   // Checks an existing directory

   local aResult

   if Right( cDirName, 1 ) == "\" .or. Right( cDirName, 1 ) == "/"
      cDirName = Left( cDirName, Len( cDirName ) - 1 )
   endif

   aResult = Directory( cDirName, "DHS" )

return Len( aResult ) == 1 .and. "D" $ aResult[ 1 ][ 5 ]

//----------------------------------------------------------------------------//

function CopyFiles()

   QFile( "assets:/FiveTouch.ch" ):copy( "FiveTouch.ch" )
   QFile( "assets:/hbclass.ch" ):copy( "hbclass.ch" )
   QFile( "assets:/hboo.ch" ):copy( "hboo.ch" )

return nil

//----------------------------------------------------------------------------//

function SelFile( cPath )

   local oDlg := QDialog()
   local oFiles := QListWidget( oDlg )
   local oBtnOk := QPushButton( oDlg )
   local oBtnCancel := QPushButton( oDlg )
   local aFiles, cFileName := ""

   DEFAULT cPath := "./"
   
   oDlg:ReSize( 400, 390 )
   oDlg:Move( 450, 150 )
   oDlg:SetWindowTitle( "Select a file" )
   oDlg:SetObjectName( "oWnd" )
   // oDlg:SetStyleSheet( "#oWnd{ background-color: rgb( 0, 0, 100 ); }" )

   oFiles:Move( 10, 10 )
   oFiles:Resize( 380, 320 )

   ReadFiles( cPath, oFiles )

   oFiles:Connect( "itemClicked(QListWidgetItem*)",;
                   { | oItem | cFileName := oItem:Text } )

   oBtnOk:Move( 110, 340 )
   oBtnOk:ReSize( 80, 40 )
   oBtnOk:SetText( "Ok" )
   oBtnOk:Connect( "clicked()", { || If( lIsDir( cPath + cFileName ) .or. ;
    	                                   Right( cFileName, 1 ) == ".",;
                                     ( cPath += cFileName + "/", ReadFiles( cPath, oFiles ) ),;
   	                               oDlg:Done( 1 ) ) } )

   oBtnCancel:Move( 220, 340 )
   oBtnCancel:ReSize( 80, 40 )
   oBtnCancel:SetText( "Cancel" )
   oBtnCancel:Connect( "clicked()", { || cFileName := "", oDlg:Done( 2 ) } )

   oDlg:Center()
   oDlg:Exec()

return cPath + cFileName

//----------------------------------------------------------------------------//
