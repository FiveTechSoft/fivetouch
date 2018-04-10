#include "FiveTouch.ch"

#define SCI_GOTOLINE            2024
#define SCI_STYLECLEARALL       2050
#define SCI_STYLESETFORE        2051
#define SCI_STYLESETBACK        2052
#define SCI_SETCARETLINEVISIBLE 2096
#define SCI_SETCARETLINEBACK    2098
#define SCI_GETLINECOUNT        2154
#define SCI_SETLEXER            4001
#define SCI_SETKEYWORDS         4005

#define SCE_FS_COMMENTLINE         2
#define SCE_FS_KEYWORD             7
#define SCE_FS_KEYWORD2            8
#define SCE_FS_NUMBER             11
#define SCE_FS_STRING             12
#define SCE_FS_PREPROCESSOR       13
#define SCE_FS_OPERATOR           14

#define SCLEX_FLAGSHIP            73

#define STYLE_DEFAULT             32

static oWndMain

//----------------------------------------------------------------------------//

CLASS TIde

   DATA oWndMain
   DATA oFolder
   DATA aEditors INIT {}
   DATA oEditor
   DATA lPhoneMode INIT .T.
   DATA oFuncList

   #ifdef FROM_OSX
      DATA lScintilla INIT .T.
   #else
      DATA lScintilla INIT .T.
   #endif

   METHOD New() CONSTRUCTOR
   METHOD PhoneMode()
   METHOD OpenFile()
   METHOD SaveFile()
   METHOD SelFile() INLINE QSelFile( ::oWndMain,, QStandardPaths():writableLocation( 9 ) )
   METHOD Setup()
   METHOD SetupEditor()
   METHOD CloseFile()
   METHOD FillFuncList()

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New() CLASS TIde

   ::oWndMain = QDialog()
   ::oWndMain:ShowMaximized()	
   ::oWndMain:SetColor( nRgb( 170, 0, 0 ) )

   if oWndMain == nil
      oWndMain = ::oWndMain
   endif

return Self

//----------------------------------------------------------------------------//

METHOD FillFuncList() CLASS TIde

   local nLines := ::oEditor:GetLineCount(), n 
   local aFuncs := {}, aTemp := {}, cLine
   local aTokens, cToken1, cToken2	

   for n = 1 to nLines
      cLine = ::oEditor:GetLine( n )	
      cLine = AllTrim( StrTran( cLine, hb_eol(), "" ) )
      aTokens = hb_ATokens( cLine )
      if Len( aTokens ) == 0
         loop
      endif   			
      cToken1 = Lower( aTokens[ 1 ] )
      if Len( aTokens ) == 1
         cToken2 = ""
      else   			
         cToken2 = Lower( aTokens[ 2 ] )
      endif   			
      if Len( cToken1 ) >= 4 .and. ;
     		Left( cToken1, 4 ) $ "#xcom,stat,func,proc,clas,meth,hb_f"
         if Left( cToken1, 4 ) == "stat"
            if Left( cToken2, 4 ) $ "func" .or. Left( cToken2, 4 ) $ "proc"			
               AAdd( aTemp, { cLine, n, n, Upper( cLine ) } )
            endif
         else   				
            AAdd( aTemp, { cLine, n, n, Upper( cLine ) } )
         endif   				
      endif
      if Left( cToken1, 4 ) $ "retu" .or. cToken1 == "}"
         if ! Empty( ATail( aTemp ) )
            ATail( aTemp )[ 3 ] = n
         endif   
      endif
   next

   while ( n := AScan( aTemp, { | a | "METHOD" $ a[ 4 ] .and. ;
                                      ! "CLASS" $ a[ 4 ] .and. ;
                                      ! "INLINE" $ a[ 4 ] .and. ;
                                      ! "VIRTUAL" $ a[ 4 ] } ) ) != 0
    	   ADel( aTemp, n )
      	ASize( aTemp, Len( aTemp ) - 1 )
   end

   aFunLines = {}

   ASort( aTemp,,, { | x, y | x[ 4 ] < y[ 4 ] } )
   for n = 1 to Len( aTemp )
     AAdd( aFunLines, { aTemp[ n ][ 2 ], aTemp[ n ][ 3 ] } )
     AAdd( aFuncs, aTemp[ n ][ 1 ] )
   next     

   ::oFuncList:Clear()
   	
   for n = 1 to Len( aFuncs )
      ::oFuncList:AddItem( aFuncs[ n ] )
   next   		
   
return nil         

//----------------------------------------------------------------------------//

METHOD PhoneMode() CLASS TIde

   local oLayout
   local oBtnNew, oBtnOpen, oBtnSave, oBtnClose
   local oBtnCopy, oBtnPaste, oBtnRun
   local oBtnSetup, oBtnMore, oBtnExit

   ::oFolder = QTabWidget( ::oWndMain )
   ::oFolder:Connect( "tabBarClicked(int)",;
                      { | nIndex | ::oEditor := ::oFolder:Widget( nIndex ) } )
   	
   oLayout = QVBoxLayout()	
   ::oWndMain:SetLayout( oLayout )
   oLayout:AddWidget( ::oFolder )
   ::oWndMain:SetWindowTitle( "FiveTouch" )

   ::OpenFile( "tutor01.prg" )

   oBtnNew := QPushButton( ::oWndMain )
   oBtnNew:SetText( "New" )
   oBtnNew:Connect( "clicked()", { || ::OpenFile() } )	
   oLayout:AddWidget( oBtnNew )
   oBtnNew:Hide()

   oBtnOpen := QPushButton( ::oWndMain )
   oBtnOpen:SetText( "Open" )
   oBtnOpen:Connect( "clicked()", { || ::OpenFile( ::SelFile() ) } )
   oLayout:AddWidget( oBtnOpen )

   oBtnSave := QPushButton( ::oWndMain )
   oBtnSave:SetText( "Save" )
   oBtnSave:Connect( "clicked()", { || ::SaveFile() } )	
   oLayout:AddWidget( oBtnSave )
   oBtnSave:Hide()

   oBtnClose := QPushButton( ::oWndMain )
   oBtnClose:SetText( "Close" )
   oBtnClose:Connect( "clicked()", { || ::CloseFile() } )
   oLayout:AddWidget( oBtnClose )
   oBtnClose:Hide()

   oBtnCopy := QPushButton( ::oWndMain )
   oBtnCopy:SetText( "Copy" )
   oBtnCopy:Connect( "clicked()", { || ::oEditor:Copy() } )	
   oLayout:AddWidget( oBtnCopy )
   oBtnCopy:Hide()

   oBtnPaste := QPushButton( ::oWndMain )
   oBtnPaste:SetText( "Paste" )
   oBtnPaste:Connect( "clicked()", { || ::oEditor:Paste() } )	
   oLayout:AddWidget( oBtnPaste )
   oBtnPaste:Hide()

   oBtnRun := QPushButton( ::oWndMain )
   oBtnRun:SetText( "Run" )
   oBtnRun:Connect( "clicked()", { || RunScript( ::oEditor:Text() ) } ) 
   oLayout:AddWidget( oBtnRun )

   oBtnSetup := QPushButton( ::oWndMain )
   oBtnSetup:SetText( "Settings" )
   oBtnSetup:Connect( "clicked()", { || ::Setup() } )	
   oLayout:AddWidget( oBtnSetup )
   oBtnSetup:Hide()	

   oBtnExit := QPushButton( ::oWndMain )
   oBtnExit:SetText( "Exit" )
   oBtnExit:Connect( "clicked()", { || ::oWndMain:Done( 1 ) } )	
   oLayout:AddWidget( oBtnExit )
   oBtnExit:Hide()	

   oBtnMore := QPushButton( ::oWndMain )
   oBtnMore:SetText( "More" )
   oBtnMore:Connect( "clicked()", { || If( oBtnMore:Text() == "More",;
                                          ( oBtnNew:Show(), oBtnSave:Show(),;
                                            oBtnClose:Show(), oBtnCopy:Show(),;
                                            oBtnPaste:Show(), oBtnSetup:Show(),;
                                            oBtnExit:Show(), oBtnMore:SetText( "Less" ) ),;
                                          ( oBtnNew:Hide(), oBtnSave:Hide(),;
                                            oBtnClose:Hide(), oBtnCopy:Hide(),;
                                            oBtnPaste:Hide(), oBtnSetup:Hide(),;
                                            oBtnExit:Hide(), oBtnMore:SetText( "More" ) ) ) } )														  
   oLayout:AddWidget( oBtnMore )

   ::oWndMain:Exec()
   
return nil   	

//----------------------------------------------------------------------------/

METHOD OpenFile( cFileName ) CLASS TIde

   if cFileName == "./"
      return nil
   endif   		

   DEFAULT cFileName := "noname.prg"

   if ! ::lScintilla
      AAdd( ::aEditors, ::oEditor := QTextEdit( ::oWndMain ) )
   else
      AAdd( ::aEditors, ::oEditor := QSciScintilla( ::oWndMain ) )
   endif
   	
   ::oEditor:cFileName = cFileName 	

   ::oFolder:AddTab( ::oEditor, cFileNoPath( cFileName ) )
   ::oFolder:SetCurrentIndex( ::oFolder:Count() - 1 )

   ::SetupEditor()
   	
   if File( cFileName )   		
      ::oEditor:SetText( MemoRead( cFileName ) )
   else
      ::oEditor:SetText( '#include "FiveTouch.ch"' + hb_eol() + hb_eol() + ;
                         "function Main()" + ;
                         hb_eol() + hb_eol() + ;
                         '   MsgInfo( "Hello world" )' + hb_eol() + hb_eol() + ;
                         "return nil" )
   endif                    							  

   if ! ::lPhoneMode
      ::FillFuncList()
   endif

return nil

//----------------------------------------------------------------------------//

METHOD SaveFile() CLASS TIde

  local cFileName := ::oFolder:CurrentWidget():cFileName

  if File( cFileName )
     if MsgYesNo( "File " + cFileName + " already exists" + hb_eol() + ;
      	         "Do you want to overwrite it ?", "Attention" )
        MemoWrit( cFileName, oFolder:CurrentWidget():Text() )
     else
        if MsgYesNo( "Do you want to save it with a different name ?",;
                     "Attention" )
           cFileName = MsgGet( "Save as filename" )
           if ! Empty( cFileName )
              if File( cFileName )
                 MsgInfo( "That file already exists" )
              else
                 MemoWrit( cFileName, ::oFolder:CurrentWidget():Text() )
                 ::oFolder:SetTabText( ::oFolder:CurrentIndex, cFileName )
                 ::oFolder:CurrentWidget:cFileName = cFileName					  
              endif
           endif   
        endif   			  
     endif
  else   	  
     MemoWrit( cFileName, ::oFolder:CurrentWidget():Text() )          						  
  endif   	  

return nil

//----------------------------------------------------------------------------//

METHOD Setup() CLASS TIde

   local oDlg := QDialog()
   local oChkScintilla
   local oBtnOk, oBtnCancel	
   	
   oDlg:SetWindowTitle( "Settings" )
   
   oChkScintilla = QCheckBox( oDlg )	
   oChkScintilla:Move( 30, 30 )
   oChkScintilla:SetText( "use Scintilla" )	
   oChkScintilla:SetCheckState( If( ::lScintilla, 2, 0 ) )
   	
   oBtnOk = QPushButton( oDlg )
   oBtnOk:SetText( "Ok" )
   oBtnOk:Move( 110, 210 )
   oBtnOk:Resize( 80, 30 )	
   oBtnOk:Connect( "clicked()",;
   	{ || ::lScintilla := ( oChkScintilla:CheckState == 2 ),;
      	  ::oWndMain:Resize( ScreenWidth(), ScreenHeight() ), oDlg:Done( 1 ) } )
   oBtnOk:SetStyleSheet( "min-height: 50 px;" )        			  

   oBtnCancel = QPushButton( oDlg )
   oBtnCancel:SetText( "Cancel" )
   oBtnCancel:Move( 220, 210 )
   oBtnCancel:Resize( 80, 30 )	
   oBtnCancel:Connect( "clicked()", { || oDlg:Done( 2 ) } )
   oBtnCancel:SetStyleSheet( "min-height: 50 px;" )        			  

   oDlg:Resize( 400, 300 )   		
   oDlg:Center()
   oDlg:Exec()
   
return nil   	

//----------------------------------------------------------------------------//

METHOD SetupEditor() CLASS TIde

   local oFont := QFont()
   	
   oFont:SetFamily( "Courier" )
   oFont:SetFixedPitch( .T. )
   
   if ! File( "c:\windows\notepad.exe" )	
      oFont:SetPointSize( 17 )  
   else   		
      oFont:SetPointSize( 13 )  
   endif
   	
   ::oEditor:SetFont( oFont )	

   ::oEditor:SendScintilla( SCI_SETLEXER, SCLEX_FLAGSHIP )

   ::oEditor:SendScintilla( SCI_STYLESETBACK, STYLE_DEFAULT, nRgb( 160, 160, 160 ) ) 
   ::oEditor:SendScintilla( SCI_STYLECLEARALL, 0 )

   ::oEditor:SendScintilla( SCI_SETKEYWORDS, 0,;
       "class from data classdata method inline virtual setget endclass init " + ;
       "function return retu " + ;
       "define activate window title maximized color style on click paint resize " + ;
       "bitmap adjust noborder pixel design " + ;
       "brush " + ;
       "buttonbar filename button size of 2007 " + ;
       "checkbox " + ;
       "combobox var items " + ;
       "dialog center centered " + ;
       "explorerbar " + ;
       "folder prompts " + ;
       "font bold " + ;
       "get " + ;		 
       "group " + ;
       "icon " + ;
       "image " + ;
       "mdi mdichild menupos " + ;
       "msgbar prompt keyboard " + ;
       "menu menuitem action separator endmenu mru section " + ;
       "resource " + ;
       "say " + ;		 
       "splitter vertical previous controls hinds " + ;
       "tooltip message keyboard maximized " + ;
       "valid " + ;
       "when " + ;
       "xbrowse lines autocols recordset autosort " + ;
       "additem addtab addwidget " +;
       "connect currentrow exec height hide " +;
       "move processevents " +;
       "qapplication qcombobox qcheckbox qdialog qfiledialog qhboxlayout qlabel " + ;
       "qlineedit qlistview qlistwidget " +;
       "qpushbutton qslider qstandarditem qstandarditemmodel qstandardpaths " +;
       "qtableview qtabwidget qtablewidget qtablewidgetitem qtextedit qtoolbar " + ;
       "qtoolbutton qvboxlayout qwidget " + ;
       "resize " + ;
       "setcellwidget setfamily sethorizontalheaderitem setfixedpitch " + ;
       "setpointsize " + ;
       "setcolor setcolumncount setfixedheight setfixedwidth setfocus " + ;
       "setitem setlayout setrowcount setsliderposition setnum " +;
       "setrange settext settickinterval setstylesheet setwindowtitle " +;
       "show showmaximized " +;
       "takeitem " + ;
       "widget width " )
       
   ::oEditor:SendScintilla( SCI_SETKEYWORDS, 1,;
       "local public static private " + ;
       "if else endif " + ;
       "do while endwhile end " + ;
       "do case otherwise endcase " + ;
  	    "for next " + ;
       "nil super " )   

   ::oEditor:SendScintilla( SCI_STYLESETFORE, SCE_FS_KEYWORD, nRgb( 0, 128, 0 ) )
   ::oEditor:SendScintilla( SCI_STYLESETFORE, SCE_FS_KEYWORD2, nRgb( 0, 0, 255 ) )
   ::oEditor:SendScintilla( SCI_STYLESETFORE, SCE_FS_PREPROCESSOR, nRgb( 128,  0,  0 ) ) 	
   ::oEditor:SendScintilla( SCI_STYLESETFORE, SCE_FS_STRING, nRgb( 255, 255, 0 ) ) 	
   ::oEditor:SendScintilla( SCI_STYLESETFORE, SCE_FS_NUMBER, nRgb( 255, 0, 0 ) ) 	
   ::oEditor:SendScintilla( SCI_STYLESETFORE, SCE_FS_COMMENTLINE, nRgb( 0, 255, 0 ) ) 	
   ::oEditor:SendScintilla( SCI_STYLESETFORE, SCE_FS_OPERATOR, nRgb( 0, 128, 128 ) ) 	

   ::oEditor:SetMarginsFont( oFont )         				
   ::oEditor:SetMarginLineNumbers( 0, .T. ) 
   // nRgb(215,128,26) ) ) //nRgb(237,145,37) )) //nRgb(121,199,40) )) //nRgb( 126, 199, 66) ) ) //nRgb( 81, 81, 81 ) ) ) //QColor( "#00FFFF" ) )
   ::oEditor:SetMarginsBackgroundColor( QColor( nRgb( 81, 81, 81 )))
   ::oEditor:SetMarginWidth( 0, QFontMetrics( oFont ):Width( "00000" ) )	
            				
   ::oEditor:SendScintilla( SCI_SETCARETLINEBACK, nRgb( 0, 179, 179 ) )
   ::oEditor:SendScintilla( SCI_SETCARETLINEVISIBLE, 1 )	

return nil       		 

//----------------------------------------------------------------------------//

METHOD CloseFile() CLASS TIde

   ::oFolder:RemoveTab( ::oFolder:CurrentIndex )

return nil

//----------------------------------------------------------------------------//

function WndMain()

return oWndMain

//----------------------------------------------------------------------------//
