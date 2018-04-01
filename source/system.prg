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
