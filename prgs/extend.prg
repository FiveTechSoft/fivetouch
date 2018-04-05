#ifdef FROM_OSX
   #include "../harbour/contrib/xhb/xhbcls.ch"
#else
   #include "c:\harbour\contrib\xhb\xhbcls.ch"
#endif

//----------------------------------------------------------------------------// 

function ExtendClasses()

   // Scintilla

   EXTEND CLASS QSciScintilla WITH DATA cFileName
   
   EXTEND CLASS QSciScintilla WITH MESSAGE GetLineCount INLINE ;
      ::Lines()

   EXTEND CLASS QSciScintilla WITH MESSAGE GetLine( nLine ) INLINE ;
      ::Text( nLine - 1 )

   EXTEND CLASS QSciScintilla WITH MESSAGE Send( nMsg, nWParam, nLParam ) INLINE ;
      ::SendScintilla( nMsg, nWParam, nLParam )
      
   EXTEND CLASS QSciScintilla WITH MESSAGE GotoLine( nLine ) INLINE ;
      ::Send( SCI_GOTOLINE, nLine - 1, 0 )	

   // QDialog

   EXTEND CLASS QDialog WITH MESSAGE Center INLINE ;
      ::Move( ScreenWidth() / 2 - ::Width / 2, ScreenHeight() / 2 - ::Height / 2 )

   EXTEND CLASS QDialog WITH MESSAGE SetColor( nRgbColor ) INLINE ;
      WndSetColor( Self, nRgbColor )
      
   EXTEND CLASS QDialog WITH MESSAGE End( nResult ) INLINE ;
      ::Done( If( nResult == nil, 1, nResult ) )	 

   // QTextEdit

   EXTEND CLASS QTextEdit WITH DATA cFileName
   
   EXTEND CLASS QTextEdit WITH MESSAGE SendScintilla INLINE nil	

   EXTEND CLASS QTextEdit WITH MESSAGE SetMarginsFont INLINE nil	

   EXTEND CLASS QTextEdit WITH MESSAGE SetMarginLineNumbers INLINE nil	

   EXTEND CLASS QTextEdit WITH MESSAGE SetMarginsBackGroundColor INLINE nil	

   EXTEND CLASS QTextEdit WITH MESSAGE SetMarginWidth INLINE nil	

   EXTEND CLASS QTextEdit WITH MESSAGE GetLineCount ;
   	INLINE Len( hb_ATokens( ::ToPlainText(), hb_Eol() ) )	

   EXTEND CLASS QTextEdit WITH MESSAGE GetLine( nLine ) ;
    	INLINE MemoLine( ::ToPlainText(),, nLine )

   EXTEND CLASS QTextEdit WITH MESSAGE Text INLINE ::ToPlainText()

   // QCheckBox

   EXTEND CLASS QCheckBox WITH DATA bChange

return nil

//----------------------------------------------------------------------------//
