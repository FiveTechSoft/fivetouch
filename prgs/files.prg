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
