#ifdef READ_CH
   TEXT INTO cCode
endif
#ifndef FTVERSION
#define FTVERSION 2.0

#define CRLF hb_eol()

#command ? [ <list,...> ] => ConsoleOut( [ { <list> } ] )

#xcommand TEXT INTO <v> => #pragma __cstream|<v>:=%s

#xcommand DEFINE WINDOW <oWnd> ;
             [ TITLE <cTitle> ] ;
             [ COLOR <nRGBColor> ] ;
       => ;      
             <oWnd> := QDialog() ;;
             <oWnd>:ShowMaximized() ;;				 
             [; <oWnd>:SetWindowTitle( IfNil( <cTitle>, "FiveTouch" ) ) ] ; 
             [; <oWnd>:SetColor( IfNil( <nRGBColor>, nRgb( 255, 0, 0 ) ) ) ] ;;
             <oWnd>:ShowMaximized()				 
             
#xcommand ACTIVATE WINDOW <oWnd> ;
             [ ON INIT <uInit> ] ;				 
       => ;
          [ Eval( <{uInit}> ) ] ;;
          <oWnd>:Exec()			 

#xcommand DEFINE DIALOG <oDlg> ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ TITLE <cTitle> ] ;
       => ;      
             <oDlg> := QDialog() ;
             [; <oDlg>:SetWindowTitle( IfNil( <cTitle>, "FiveTouch" ) ) ] ; 
             [; <oDlg>:ReSize( IfNil( <nWidth>, 400 ), IfNil( <nHeight>, 300 ) ) ]
 
#xcommand ACTIVATE DIALOG <oDlg> ;
             [ <center: CENTER, CENTERED> ] ; 
       => ;
          [ <oDlg>:Center( <.center.> ) ;] ;		 
          <oDlg>:Exec()  

#xcommand @ <nRow>, <nCol> SAY <oSay> PROMPT <cPrompt> ;
             [ OF <oWnd> ] ;
       => ;     
          <oSay> := QLabel( [<oWnd>] ) ;
          [; <oSay>:SetText( <cPrompt> ) ] ;
          [; <oSay>:Move( <nCol>, <nRow> ) ]

#xcommand @ <nRow>, <nCol> GET <oGet> ;
             [ VAR <uData> ] ;
             [ OF <oWnd> ] ;
             [ SIZE <nWidth>, <nHeight> ] ;				 
       => ;     
          <oGet> := QLineEdit():New( <oWnd> ) ;
          [; <oGet>:SetText( IfNil( <uData>, "" ) ) ] ;
          [; <oGet>:Move( <nCol>, <nRow> ) ] ;
          [; <oGet>:Resize( IfNil( <nWidth>, 80 ), IfNil( <nHeight>, 30 ) ) ] ;			 
          [; <oGet>:Connect( "textChanged(QString)",;
                    { | cValue | <uData> := cValue } ) ]

#xcommand @ <nRow>, <nCol> BUTTON <oBtn> ;
             [ PROMPT <cPrompt> ] ;
             [ OF <oWnd> ] ;
             [ ACTION <uAction> ] ;
             [ SIZE <nWidth>, <nHeight> ] ;				 
       => ;     
          <oBtn> := QPushButton():New( <oWnd> ) ;
          [; <oBtn>:SetText( IfNil( <cPrompt>, "" ) ) ] ;
          [; <oBtn>:Move( <nCol>, <nRow> ) ] ;
          [; <oBtn>:Connect( "clicked()", <{uAction}> ) ] ;
          [; <oBtn>:Resize( IfNil( <nWidth>, 80 ), IfNil( <nHeight>, 30 ) ) ]			 
          			 
#xcommand DEFINE BAR <oBar> OF <oWnd>;
       => ;     
          <oBar> := QToolBar ( oDlg ) ;          
          [; <oBar>:resize( 200, 40 ) ] ;
          [; <oBar>:Move( 0, 0  ) ]

#xcommand DEFINE SEPARATOR OF <oBar>;
       => ;     
          <oBar>:addSeparator ()          

#xcommand DEFINE BUTTONBAR <oBtn> OF <oWnd> ;
              [ IMAGE <cImage> ];
              [ TOOLTIP <cToolTip> ];
              [ ACTION <cAction> ];
       => ;     
          <oBtn> := QAction ( <oWnd> ) ;          
          [; <oBtn>:setIcon( QIcon( <cImage> ) ) ] ;
          [; <oBtn>:setToolTip( <cToolTip> ) ] ;
          [; <oBtn>:connect( "triggered(bool)", {|| <cAction> } ) ] ;
	  [; <oWnd>:addAction( <oBtn> ) ]

#xcommand @ <nRow>, <nCol> IMAGE <oImage> ;
             [ FILE <cFile> ] ;
             [ SIZE <nWidth>, <nHeight> ] ;
	     [ OF <oWnd> ] ;
       => ;     
          <oImage> := QLabel( <oWnd> ) ;    
	  [; <oImage>:move( <nCol>, <nRow> ) ];
	  [; <oImage>:resize( <nWidth>, <nHeight> ) ];
	  [; <oImage>:SetPixmap( QPixmap( <cFile> ) ) ];
	  [; <oImage>:setStyleSheet( "border: 1px solid blue;" ) ]

#xcommand @ <nRow>, <nCol> COMBOBOX <oCbx> ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ VAR <uData> ] ;
             [ OF <oWnd> ] ;
             [ ITEMS <aItems> ] ;
       => ;
          <oCbx> := QComboBox():New( <oWnd> ) ;
          [; <oCbx>:Resize( IfNil( <nWidth>, 80 ), IfNil( <nHeight>, 30 ) ) ] ;
          [; AEval( <aItems>, { | cItem | <oCbx>:AddItem( cItem ) } ) ] ;
          [; <oCbx>:CurrentText( <uData> ) ] ;
          [; <oCbx>:Move( <nCol>, <nRow> ) ] ;
          [; <oCbx>:Connect( "currentIndexChanged(QString)",;
                    { | cValue | <uData> := cValue } ) ]

#xcommand @ <nRow>, <nCol> LISTBOX <oLbx> ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ VAR <uData> ] ;
             [ OF <oWnd> ] ;
             [ ITEMS <aItems> ] ;
       => ;
          <oLbx> := QListWidget():New( <oWnd> ) ;
          [; <oLbx>:Resize( IfNil( <nWidth>, 80 ), IfNil( <nHeight>, 30 ) ) ] ;
          [; AEval( <aItems>, { | cItem | <oLbx>:AddItem( cItem ) } ) ] ;
          [; AEval( <aItems>, { | cItem, nItem | If( cItem == <uData>, <oLbx>:SetCurrentRow( nItem - 1 ), ) } ) ] ;
          [; <oLbx>:Move( <nCol>, <nRow> ) ]

#xcommand @ <nRow>, <nCol> CHECKBOX <oChk> ;
             [ VAR <lVar> ] ;
             [ PROMPT <cPrompt> ] ;
             [ OF <oWnd> ] ;
             [ ON CHANGE <uAction> ] ;				 
       => ;     
          <oChk> := QCheckBox():New( [<cPrompt>], <oWnd> ) ;
          [; <oChk>:SetCheckState( If( <lVar>, 0, 2 ) ) ] ;
          [; <oChk>:Move( <nCol>, <nRow> ) ] ;
          [; <oChk>:Connect( "stateChanged(int)",;
                    { | nState | <lVar> := ( nState == 2 ),;
                      			   If( <oChk>:bChange != nil, Eval( <oChk>:bChange ),) } ) ] ;
          [; <oChk>:bChange := IfNil( <{uAction}>, nil ) ]                      										  

#xcommand @ <nRow>, <nCol> TREEVIEW <oTV> ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ OF <oWnd> ] ;
       => ;     
          <oTV> := QTreeView():New( <oWnd> ) ;
          [; <oTV>:Resize( IfNil( <nWidth>, 80 ), IfNil( <nHeight>, 30 ) ) ] ;
          [; <oTV>:Move( <nCol>, <nRow> ) ]
          
#xcommand @ <nRow>, <nCol> SLIDER <oSlide> ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ VAR <nVar> ] ;
             [ OF <oWnd> ] ;
             [ <h: HORIZONTAL> ] ;
       => ;
          <oSlide> := QSlider():New( [If( <.h.>, 1, 2 ), ]<oWnd> ) ;
          [; <oSlide>:Resize( IfNil( <nWidth>, 80 ), IfNil( <nHeight>, 30 ) ) ] ;
          [; <oSlide>:Move( <nCol>, <nRow> ) ]

#xcommand @ <nRow>, <nCol> FOLDER <oFolder> ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ OF <oWnd> ] ;
             [ PROMPTS <cPrompt,...> ] ;
       => ;
          <oFolder> := QTabWidget():New( <oWnd> ) ;
          [; <oFolder>:Resize( IfNil( <nWidth>, 80 ), IfNil( <nHeight>, 30 ) ) ] ;
          [; AEval( {<cPrompt>}, { | cItem | <oFolder>:AddTab( QWidget(), cItem ) } ) ] ;
          [; <oFolder>:Move( <nCol>, <nRow> ) ]
          
#xcommand @ <nRow>, <nCol> BROWSE <oBrw> ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ OF <oWnd> ] ;
             [ FIELDS [<Flds,...>] ] ;
             [ <head:HEAD,HEADER,HEADERS,TITLE> <aHeaders,...> ] ;
       => ;
          <oBrw> := QTableView( <oWnd> ) ;
          [; <oBrw>:Resize( IfNil( <nWidth>, 80 ), IfNil( <nHeight>, 80 ) ) ] ;
          [; <oBrw>:Move( <nCol>, <nRow> ) ] ;
          [; oModel := QStandardItemModel( 0, If( {<aHeaders>} == NIL, 0, Len( {<aHeaders>} ) ), <oWnd> ) ] ;
          [; AEval( {<aHeaders>}, { | cItem, nItem | oModel:SetHorizontalHeaderItem( nItem - 1, QStandardItem( cItem ) ) } ) ] ;
          [; DbEval( { || AEval( {<Flds>}, { | cItem, nItem | oModel:SetItem( RecNo() - 1, nItem - 1, QStandardItem( cItem ) ) } ) } ) ] ;
          [; <oBrw>:SetModel( oModel ) ]

#xcommand @ <nRow>, <nCol> RICHEDIT <oRTF> [ VAR <uVar> ] ;
             [ OF <oWnd> ] ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ FONT <oFont> ] ;
             [ <pixel: PIXEL> ] ;
             [ MESSAGE <cMsg> ] ;
             [ <lHScroll: HSCROLL> ] ;
             [ <readonly: READONLY, NO MODIFY> ] ;
             [ WHEN <uWhen> ] ;
             [ VALID <uValid> ] ;
             [ ON CHANGE <uChange> ] ;
             [ <lDesign: DESIGN> ] ;
             [ <lHighlight: HIGHLIGHT> ] ;
             [ <file: FILE, FILENAME> <cFileName> ] ;
             [ RTFSIZE <nRTFSize> ] ;
             [ <lNoURL: NO URL> ] ;
             [ <lNoScroll: NO SCROLL> ] ;
             [ <lNoBorder: NOBORDER, NO BORDER> ] ;
       => ;
          <oRTF> := QTextEdit( <oWnd> ) ;
          [; <oRTF>:Resize( IfNil( <nWidth>, 80 ), IfNil( <nHeight>, 80 ) ) ] ;
          [; <oRTF>:Move( <nCol>, <nRow> ) ] ;
          [; <oRTF>:setAcceptRichText( .T. ) ]          

#endif

#ifdef READ_CH
   ENDTEXT
endif
