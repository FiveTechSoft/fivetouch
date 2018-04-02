//----------------------------------------------------------------------------//

function RunScript( cCode )

   local oHrb, bOldError
 
   if Empty( cCode )
      return nil
   endif   		
   
   oHrb = HB_CompileFromBuf( StrTran( cCode, "Main", "__Main" ), .T., "-n" )
   
   if oHrb == nil
      MsgInfo( "Error in code" )
   else   		
      if ! Empty( oHrb )
         BEGIN SEQUENCE
         bOldError = ErrorBlock( { | o | DoBreak( o ) } )
         hb_HrbRun( oHrb )
         END SEQUENCE
         ErrorBlock( bOldError )
      endif
   endif   		

return nil

//----------------------------------------------------------------------------// 

function DoBreak( oError )

   local cInfo := oError:operation, n
   local cCallStack := ""

   if ValType( oError:Args ) == "A"
      cInfo += hb_eol() + "Args:" + hb_eol()
      for n = 1 to Len( oError:Args )
         cInfo += "[" + Str( n, 4 ) + "] = type " + ValType( oError:Args[ n ] ) + ;
                   ", value: " + cValToChar( oError:Args[ n ] ) + hb_eol()
      next
   endif

   n = 8
   while ! Empty( ProcName( n ) )
      cCallStack += "Called from: " + ProcFile( n ) + " => " + ;
       			     Trim( ProcName( n ) ) + ;
                    "( " + AllTrim( Str( ProcLine( n ) ) + " )" ) + hb_eol()
      n++
   end
      
   MsgInfo( oError:Description + hb_eol() + cInfo + hb_eol() + hb_eol() + ;
            cCallStack, "Error at line:" + " " + ;
            SubStr( oError:operation, At( ":", oError:operation ) + 1 ) )

   BREAK

return nil

//----------------------------------------------------------------------------/
