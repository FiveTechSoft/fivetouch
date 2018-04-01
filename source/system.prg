//----------------------------------------------------------------------------// 

function ScreenWidth()

   local oRect := QApplication():Desktop():AvailableGeometry()

return oRect:Width()

//----------------------------------------------------------------------------// 

function ScreenHeight()

   local oRect := QApplication():Desktop():AvailableGeometry()

return oRect:Height()

//----------------------------------------------------------------------------//

function SysRefresh()

return QApplication():ProcessEvents()

//----------------------------------------------------------------------------//

function DataLocation()

return QStandardPaths():StandardLocations( 9 ):Value( 0 )

//----------------------------------------------------------------------------//

function DownloadLocation()

return QStandardPaths():StandardLocations( 14 ):Value( 0 )

//----------------------------------------------------------------------------//

function nRGB( nRed, nGreen, nBlue )

return ( nBlue * 65536 ) + ( nGreen * 256 ) + nRed

//----------------------------------------------------------------------------//

function WndSetColor( oWnd, nRGBColor )

   local oPalette := QPalette()
   local nRed     := Int( nRGBColor / 65536 )
   local nGreen   := Int( nRGBColor / 256 )
   local nBlue    := nRGBColor - ( nRed * 65536 ) - ( nGreen * 256 )
   local oColor   := QColor( nRed, nGreen, nBlue )

   oPalette:SetColor( 10, oColor )

   oWnd:SetPalette( oPalette )

return nil

//----------------------------------------------------------------------------//
