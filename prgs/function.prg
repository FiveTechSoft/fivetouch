//----------------------------------------------------------------------------//
                  						
function cValToChar( u )

   local cType := ValType( u )

   do case
      case cType == "A"
           u = "{ ... } Len: " + AllTrim( Str( Len( u ) ) ) 

      case cType == "B"
           u = "{ || ... }"

      case cType == "N"
           u = AllTrim( Str( u ) )

      case cType == "L"
           u = If( u, ".T.", ".F." )

      case cType == "D"
           u = DToC( u )

      case cType == "O"
           u = u:ClassName() + " object"
           
      case cType == "U"     			  
           u = "nil"
   endcase

return u

//----------------------------------------------------------------------------// 

function IfNil( u, uDefault )

return If( ValType( u ) == "U", uDefault, u )

//----------------------------------------------------------------------------//